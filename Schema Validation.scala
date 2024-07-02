
// Example when Schema matches but order is different

scala> val df = Seq((1, "John", "Mayer", 1.0)).toDF("id", "fname", "lname", "version")
df: org.apache.spark.sql.DataFrame = [id: int, fname: string ... 2 more fields]

scala> import org.apache.spark.sql.types._
import org.apache.spark.sql.types._

scala> val original_fields = df.schema.fields
original_fields: Array[org.apache.spark.sql.types.StructField] = Array(StructField(id,IntegerType,false), StructField(fname,StringType,true), StructField(lname,StringType,true), StructField(version,DoubleType,false))

scala> val original_fields_name_hashmap = original_fields.map( f => f.name -> f.dataType).toMap
original_fields_name_hashmap: scala.collection.immutable.Map[String,org.apache.spark.sql.types.DataType] = Map(id -> IntegerType, fname -> StringType, lname -> StringType, version -> DoubleType)

scala> val df2 = Seq((1, "John", 1.0, "Mayer")).toDF("id", "fname", "version", "lname")
df2: org.apache.spark.sql.DataFrame = [id: int, fname: string ... 2 more fields]

scala> val target_fields = df2.schema.fields
target_fields: Array[org.apache.spark.sql.types.StructField] = Array(StructField(id,IntegerType,false), StructField(fname,StringType,true), StructField(version,DoubleType,false), StructField(lname,StringType,true))

scala> val target_fields_name_hashmap = target_fields.map( f => f.name -> f.dataType).toMap
target_fields_name_hashmap: scala.collection.immutable.Map[String,org.apache.spark.sql.types.DataType] = Map(id -> IntegerType, fname -> StringType, version -> DoubleType, lname -> StringType)


scala> val diff_fields_1 = original_fields.filter( f => original_fields_name_hashmap.get(f.name) != target_fields_name_hashmap.get(f.name) ).toList
diff_fields_1: List[org.apache.spark.sql.types.StructField] = List()


——————— ———— —————— —————— —————— ——————— ——————— ————— ———— ————— ———— ————— ——————— ———— —————— —————— —————— ——————— ——————— ————— ———— ————— ———— ————— 


// Example when Schema differ exists 

scala> val df2 = Seq((1, "John", 1.0)).toDF("id", "fname", "version")
df2: org.apache.spark.sql.DataFrame = [id: int, fname: string ... 1 more field]

scala> val target_fields = df2.schema.fields
target_fields: Array[org.apache.spark.sql.types.StructField] = Array(StructField(id,IntegerType,false), StructField(fname,StringType,true), StructField(version,DoubleType,false))

scala> val target_fields_name_hashmap = target_fields.map( f => f.name -> f.dataType).toMap
target_fields_name_hashmap: scala.collection.immutable.Map[String,org.apache.spark.sql.types.DataType] = Map(id -> IntegerType, fname -> StringType, version -> DoubleType)

scala> val diff_fields_1 = original_fields.filter( f => original_fields_name_hashmap.get(f.name) != target_fields_name_hashmap.get(f.name) ).toList
diff_fields_1: List[org.apache.spark.sql.types.StructField] = List(StructField(lname,StringType,true))



