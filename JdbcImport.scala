package main.jdbc

import org.apache.spark.sql.{DataFrame, SparkSession}

import scala.collection.mutable.{Map => MutableMap}

object JdbcImport {
   /*
      Extract full load data
   */
    private def get_full_data(spark: SparkSession, options: Map[String, String]): DataFrame = {
      try {
        spark.read.format("jdbc").options(options).load()
      } catch {
        case e: Exception => throw new UnsupportedOperationException("Error in JDBC full load - Read operation")
      }

    }

  /*
     Extract incremental data
  */
    private def get_incremental_data(spark: SparkSession, configs: Map[String, String]): DataFrame =  spark.emptyDataFrame

   /*
      Set JDBC options
   */
    private def set_jdbc_options(configs: Map[String, String]): MutableMap[String, String] = {
      val jdbc_options = MutableMap(
        "url" -> "127.0.0.1" , // configs.getOrElse("url", throw new Exception("Pass url in configs")),
        "port" -> "3306", // configs.getOrElse("port", throw new Exception("Pass port in configs")) ,
        "user" -> "root",
        "password" -> "rootroot"
      )

      if(configs.contains("query") && configs.contains("dbtable")) {
        throw new IllegalArgumentException(s"We can either query or dbtable option, can't use both.")
      }  else if (configs.contains("dbtable")) {
        jdbc_options += ("dbtable" -> configs("dbtable"))
      } else if (configs.contains("query")) {
        jdbc_options += ("query" -> configs("query"))
      } else {
        throw new Exception("Pass either query or table options, none are passed")
      }

      if (configs.contains("numPartitions")) {
        if(configs.contains("partitionColumn") && configs.contains("lowerBound") && configs.contains("upperBound")) {

        }
        else {
          val error_msg =
            s"""Error while reading jdbc connection options.
               |If numPartitions is passed then passing
               |partitionColumn, lowerBound and upperBound is mandatory
               |""".stripMargin
          throw new IllegalArgumentException(error_msg)
        }
      }
      jdbc_options
    }


    def getData(spark: SparkSession, configs: Map[String, String], readType: String = "full_load"): DataFrame = {
      val jdbc_options: MutableMap[String, String] = set_jdbc_options(configs)
      val extracted_df = readType match {
        case "full_load" => get_full_data(spark, configs)
        case "incremental_load" => get_incremental_data(spark, configs)
        case _ => throw new Exception(s"We only support 'full_load' and 'incremental_load' and nothing else")
      }
      extracted_df
    }

}
