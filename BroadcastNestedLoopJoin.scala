package main

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.{broadcast, lit}


/*
  Below example is only for demo purpose.
  CSV files don't have schema, all fields will have String type
  In join condition when added && with equality option there may be a mismatch of data types,
    to avoid that inferSchema is not enabled nor any custom schema enabled
  There will still be 1 BroadcastNestedLoopJoin BuildRight, Cross as we are performing cross JOIN
  Last solution is a better option since csv are not schema embedded, dummy df is created with "0" to avoid data types issue
 */
object BroadcastNestedLoopJoin extends App {

  val spark = SparkSession
    .builder()
    .appName("BroadcastNestedLoopJoin")
    .master("local")
    .config("spark.sql.autoBroadcastJoinThreshold", -1)
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
      .alias("emp").join(broadcast(bonus_df.alias("bon")), join_condition, "left")
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
    salary_df_1.alias("emp").join(broadcast(bonus_df_1.alias("bon")), join_condition_1, "left")
    .select($"emp.*", $"bon.*", $"bon.final".alias("bonus_amt"))


  emp_bonus_df_1.show(false)

  /*
  emp_bonus_df_1.explain()
  == Physical Plan ==
    *(1) Project [SalaryDataID#17, CalendarYear#18, EmployeeName#19, Department#20, JobTitle#21, salary#22, (cast(salary#22 as double) * 0.0) AS temp_clm#87, cast(null as string) AS min_salary#46, cast(null as string) AS max_salary#47, cast(null as string) AS final#48, cast(null as double) AS temp_clm#82, cast(null as string) AS bonus_amt#117]
      +- FileScan csv [SalaryDataID#17,CalendarYear#18,EmployeeName#19,Department#20,JobTitle#21,salary#22] Batched: false, DataFilters: [], Format: CSV, Location: InMemoryFileIndex(1 paths)[file:/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/employee-1..., PartitionFilters: [], PushedFilters: [], ReadSchema: struct<SalaryDataID:string,CalendarYear:string,EmployeeName:string,Department:string,JobTitle:str...
  */
  

  private val dummy_df = Seq(("0")).toDF("temp_clm")
  private val bonus_df_2 = bonus_df.crossJoin(broadcast(dummy_df))
  private val salary_df_2 = salary_df.crossJoin(broadcast(dummy_df))

  private val join_condition_2 = $"emp.salary".between($"bon.min_salary", $"bon.max_salary") && $"emp.temp_clm" == $"bon.temp_clm"
  private val emp_bonus_df_2 = salary_df_2.alias("emp").join(broadcast(bonus_df_2.alias("bon")), join_condition_2, "left")
    .select($"emp.*", $"bon.*", $"bon.final".alias("bonus_amt_2"))

//  emp_bonus_df_2.show(false)
//  emp_bonus_df_2.explain()

  private val final_df = List("salary1", "salary2").foldLeft(salary_df_2) {(tmp_df, col_name) =>
    tmp_df
      .alias("emp").join(broadcast(bonus_df_2).alias("bon"),
      $"$col_name".between($"bon.min_salary", $"bon.max_salary") && ($"emp.temp_clm" == $"bon.temp_clm")
      , "left")
      .withColumnRenamed(col_name, col_name + "_rounded")
  }

  final_df.show(false)
/*
  final_df.explain()
  == Physical Plan ==
    AdaptiveSparkPlan isFinalPlan=false
    +- Project [SalaryDataID#17, CalendarYear#18, EmployeeName#19, Department#20, JobTitle#21, salary#22, salary1#23 AS salary1_rounded#363, salary2#24 AS salary2_rounded#416, temp_clm#277, cast(null as string) AS min_salary#50, cast(null as string) AS max_salary#51, cast(null as string) AS final#52, cast(null as string) AS temp_clm#336, cast(null as string) AS min_salary#377, cast(null as string) AS max_salary#378, cast(null as string) AS final#379, cast(null as string) AS temp_clm#381]
      +- BroadcastNestedLoopJoin BuildRight, Cross
      :- FileScan csv [SalaryDataID#17,CalendarYear#18,EmployeeName#19,Department#20,JobTitle#21,salary#22,salary1#23,salary2#24] Batched: false, DataFilters: [], Format: CSV, Location: InMemoryFileIndex(1 paths)[file:/Users/mac/IdeaProjects/Spark-Scala-Examples/resources/employee-1..., PartitionFilters: [], PushedFilters: [], ReadSchema: struct<SalaryDataID:string,CalendarYear:string,EmployeeName:string,Department:string,JobTitle:str...
        +- BroadcastExchange IdentityBroadcastMode, [plan_id=234]
          +- LocalTableScan [temp_clm#277]
*/
}