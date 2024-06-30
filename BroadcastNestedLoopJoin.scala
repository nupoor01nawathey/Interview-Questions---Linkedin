package main

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.{broadcast, coalesce, lit}

/*
  In a Broadcast Nested Loop Join, a small DataFrame is broadcasted to all worker nodes, just like in a Broadcast Hash Join. 
  However, instead of using a hash-based join, a nested loop join is performed. Each row in the larger DataFrame is compared to each row 
  in the smaller DataFrame to find matching keys.
  
  Hash Join Algorithm
  A Hash Table is built on the smaller table of the join. The Join Column value is used as the key in the Hash Table
  For every row in the other data partitions, the Join Column value is used to query the Hash Table built in (1). 
  When Hash Table returns some value, then there is a match.

  https://towardsdatascience.com/strategies-of-spark-join-c0e7b4572bcf
*/


/*
  Below example is only for demo purpose.
  CSV files don't have schema, all fields will have String type
  In join condition when added && with equality option there may be a mismatch of data types,
    to avoid that inferSchema is not enabled nor any custom schema enabled
  Unable to see Broadcast Hash Join and CrossJoin in the query plan.. some issue on local m/c ?!?

  https://medium.com/analytics-vidhya/how-to-avoid-broadcastnestedjoin-in-spark-372d20b8e82d

  Cartesian Product Join (a.k.a. Shuffle-and-Replication Nested Loop) join works very similar to a Broadcast Nested Loop join except the dataset is not broadcasted. 
 */
object BroadcastNestedLoopJoin extends App {

  val spark = SparkSession
    .builder()
    .appName("BroadcastNestedLoopJoin")
    .master("local")
    .config("spark.sql.autoBroadcastJoinThreshold", -1)
    .config("spark.sql.crossJoin.enabled", "true") // Spark 2.0 required, Spark3.0 is default enabled CrossJoin
    .getOrCreate()

  private val emp_file_location = "/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/employee-1.csv"

  private val salary_df = spark.read.format("csv")
  .option("header", "true")
//  .option("inferSchema", "true")
  .load(emp_file_location)

  private val bonus_file_location = "/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/bonus.txt"

  private val bonus_df = spark.read.format("csv")
  .option("header", "true")
//  .option("inferSchema", "true")
  .load(bonus_file_location)

  import spark.implicits._

  private val join_condition = $"emp.salary".between($"bon.min_salary", $"bon.max_salary")
  private val emp_bonus_df =
    salary_df
      .alias("emp").join(bonus_df.alias("bon"), join_condition, "left")
    .select($"emp.*", $"bon.*", $"bon.final"
    ).alias("bonus_amt")

  emp_bonus_df.show(false)
/*
  emp_bonus_df.explain()

  == Physical Plan ==
    AdaptiveSparkPlan isFinalPlan=false
      +- Project [SalaryDataID#17, CalendarYear#18, EmployeeName#19, Department#20, JobTitle#21, salary#22, min_salary#46, max_salary#47, final#48, final#48]
        +- BroadcastNestedLoopJoin BuildRight, LeftOuter, ((salary#22 >= min_salary#46) AND (salary#22 <= max_salary#47))
          :- FileScan csv [SalaryDataID#17,CalendarYear#18,EmployeeName#19,Department#20,JobTitle#21,salary#22] Batched: false, DataFilters: [], Format: CSV, Location: InMemoryFileIndex(1 paths)[file:/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/employee-1..., PartitionFilters: [], PushedFilters: [], ReadSchema: struct<SalaryDataID:string,CalendarYear:string,EmployeeName:string,Department:string,JobTitle:str...
          +- BroadcastExchange IdentityBroadcastMode, [plan_id=60]
            +- Filter (isnotnull(min_salary#46) AND isnotnull(max_salary#47))
              +- FileScan csv [min_salary#46,max_salary#47,final#48] Batched: false, DataFilters: [isnotnull(min_salary#46), isnotnull(max_salary#47)], Format: CSV, Location: InMemoryFileIndex(1 paths)[file:/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/bonus.txt], PartitionFilters: [], PushedFilters: [IsNotNull(min_salary), IsNotNull(max_salary)], ReadSchema: struct<min_salary:string,max_salary:string,final:string>

*/

  private val bonus_df_1 = bonus_df.withColumn("temp_clm", $"max_salary"*0)
  private val salary_df_1 = salary_df.withColumn("temp_clm", $"salary"*0)

//  bonus_df_1.printSchema()
//  salary_df_1.printSchema()
  /*
    bonus_df_1
     |-- min_salary: string (nullable = true)
     |-- max_salary: string (nullable = true)
     |-- final: string (nullable = true)
     |-- temp_clm: double (nullable = true)

    salary_df_1
     |-- SalaryDataID: string (nullable = true)
     |-- CalendarYear: string (nullable = true)
     |-- EmployeeName: string (nullable = true)
     |-- Department: string (nullable = true)
     |-- JobTitle: string (nullable = true)
     |-- salary: string (nullable = true)
     |-- temp_clm: double (nullable = true)
   */

  private val join_condition_1 = ($"emp.salary".between($"bon.min_salary", $"bon.max_salary") && ($"emp.temp_clm" == $"bon.temp_clm"))
  private val emp_bonus_df_1 =
    salary_df_1.alias("emp").join(bonus_df_1.alias("bon"), join_condition_1, "left")
    .select($"emp.*", $"bon.*", $"bon.final".alias("bonus_amt"))


  emp_bonus_df_1.show(false)

  /*
  emp_bonus_df_1.explain()
  == Physical Plan ==
    *(1) Project [SalaryDataID#17, CalendarYear#18, EmployeeName#19, Department#20, JobTitle#21, salary#22, (cast(salary#22 as double) * 0.0) AS temp_clm#87, cast(null as string) AS min_salary#46, cast(null as string) AS max_salary#47, cast(null as string) AS final#48, cast(null as double) AS temp_clm#82, cast(null as string) AS bonus_amt#117]
      +- FileScan csv [SalaryDataID#17,CalendarYear#18,EmployeeName#19,Department#20,JobTitle#21,salary#22] Batched: false, DataFilters: [], Format: CSV, Location: InMemoryFileIndex(1 paths)[file:/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/employee-1..., PartitionFilters: [], PushedFilters: [], ReadSchema: struct<SalaryDataID:string,CalendarYear:string,EmployeeName:string,Department:string,JobTitle:str...
  */


  private val dummy_df = Seq(("0")).toDF("temp_clm")
  private val bonus_df_2 = bonus_df.crossJoin(dummy_df)
  private val salary_df_2 = salary_df.crossJoin(dummy_df)

  private val join_condition_2 = $"emp.salary".between($"bon.min_salary", $"bon.max_salary") && $"emp.temp_clm" == $"bon.temp_clm"
  private val emp_bonus_df_2 = salary_df_2.alias("emp").join(bonus_df_2.alias("bon"), join_condition_2, "left")
    .select($"emp.*", $"bon.*", $"bon.final".alias("bonus_amt_2"))

//  emp_bonus_df_2.show(false)
//  emp_bonus_df_2.explain()

  private val final_df = List("salary1", "salary2").foldLeft(salary_df_2) {(tmp_df, col_name) =>
    tmp_df
      .alias("emp").join(bonus_df_2.alias("bon"),
      $"$col_name".between($"bon.min_salary", $"bon.max_salary") && ($"emp.temp_clm" == $"bon.temp_clm")
      , "left")
      .withColumn(col_name + "_rounded", $"bon.final")
  }

  final_df.explain()
/*
  final_df.explain()
  == Physical Plan ==
      *(1) Project [SalaryDataID#17, CalendarYear#18, EmployeeName#19, Department#20, JobTitle#21, salary#22, salary1#23, salary2#24,
      temp_clm#152, cast(null as string) AS min_salary#50, cast(null as string) AS max_salary#51, cast(null as string) AS final#52,
      cast(null as string) AS temp_clm#211, cast(null as string) AS salary1_rounded#238, cast(null as string) AS min_salary#253,
      cast(null as string) AS max_salary#254, cast(null as string) AS final#255, cast(null as string) AS temp_clm#257,
      cast(null as string) AS salary2_rounded#294]
      +- CartesianProduct // Even if CartesianProduct only 1 value "0" is getting attached to each row in each df, not much impact...
         :- FileScan csv [SalaryDataID#17,CalendarYear#18,EmployeeName#19,Department#20,JobTitle#21,salary#22,salary1#23,salary2#24] Batched: false,
         DataFilters: [], Format: CSV,
         Location: InMemoryFileIndex(1 paths)[file:/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/employee-1..., PartitionFilters: [],
         PushedFilters: [], ReadSchema: struct<SalaryDataID:string,CalendarYear:string,EmployeeName:string,Department:string,JobTitle:str...
         +- LocalTableScan [temp_clm#152]
*/
}
