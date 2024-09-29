import org.apache.spark.sql.Row
import org.apache.spark.sql.types._

val data = Seq(
  Row(1, 704, "STANDARD", null, "PR", 30100),
  Row(2, 704, null, "PASEO COSTA DEL SUR", "PR", null),
  Row(3, 709, null, "BDA SAN LUIS", "PR", 3700),
  Row(4, 76166, "UNIQUE", "CINGULAR WIRELESS", "TX", 84000),
  Row(5, 76177, "STANDARD", null, "TX", null)
)

val schema = StructType(Array(
  StructField("id", IntegerType, nullable=false),
  StructField("zipcode", IntegerType, nullable=false),
  StructField("type", StringType, nullable=true),
  StructField("city", StringType, nullable=true),
  StructField("state", StringType, nullable=true),
  StructField("population", IntegerType, nullable=true)
))

val rdd = spark.sparkContext.parallelize(data)

val data_df = spark.createDataFrame(rdd, schema)

data_df.show(false)

/*
  +---+-------+--------+-------------------+-----+----------+
  |id |zipcode|type    |city               |state|population|
  +---+-------+--------+-------------------+-----+----------+
  |1  |704    |STANDARD|null               |PR   |30100     |
  |2  |704    |null    |PASEO COSTA DEL SUR|PR   |null      |
  |3  |709    |null    |BDA SAN LUIS       |PR   |3700      |
  |4  |76166  |UNIQUE  |CINGULAR WIRELESS  |TX   |84000     |
  |5  |76177  |STANDARD|null               |TX   |null      |
  +---+-------+--------+-------------------+-----+----------+
*/


// population column not affected possibly due to IntegerType , others are StringType so NA is accepted
data_df.na.fill("NA", Seq("type", "city", "state", "population")).show(false)
/*
  +---+-------+--------+-------------------+-----+----------+
  |id |zipcode|type    |city               |state|population|
  +---+-------+--------+-------------------+-----+----------+
  |1  |704    |STANDARD|NA                 |PR   |30100     |
  |2  |704    |NA      |PASEO COSTA DEL SUR|PR   |null      |
  |3  |709    |NA      |BDA SAN LUIS       |PR   |3700      |
  |4  |76166  |UNIQUE  |CINGULAR WIRELESS  |TX   |84000     |
  |5  |76177  |STANDARD|NA                 |TX   |null      |
  +---+-------+--------+-------------------+-----+----------+
*/


// apply separate transformation for IntegerType column
data_df.na.fill(0, Seq("population")).show(false)
/*
  +---+-------+--------+-------------------+-----+----------+
  |id |zipcode|type    |city               |state|population|
  +---+-------+--------+-------------------+-----+----------+
  |1  |704    |STANDARD|null               |PR   |30100     |
  |2  |704    |null    |PASEO COSTA DEL SUR|PR   |0         |
  |3  |709    |null    |BDA SAN LUIS       |PR   |3700      |
  |4  |76166  |UNIQUE  |CINGULAR WIRELESS  |TX   |84000     |
  |5  |76177  |STANDARD|null               |TX   |0         |
  +---+-------+--------+-------------------+-----+----------+
*/


// Types not considered while dropping rows with null or NaN
data_df.na.drop(Seq("type", "city", "state", "population")).show(false)
/*
  +---+-------+------+-----------------+-----+----------+
  |id |zipcode|type  |city             |state|population|
  +---+-------+------+-----------------+-----+----------+
  |4  |76166  |UNIQUE|CINGULAR WIRELESS|TX   |84000     |
  +---+-------+------+-----------------+-----+----------+
*/
