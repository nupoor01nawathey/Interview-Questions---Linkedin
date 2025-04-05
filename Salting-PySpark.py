
from pyspark.sql import *
from pyspark.sql.functions import *
from pyspark.sql.types import *

spark.conf.set("spark.sql.adaptive.enabled", "false")


id_values1 = [1] * 100000 + [2] * 5 + [3] * 5
table1 = spark.createDataFrame(id_values1, "int").toDF("id")


id_values2 = [1] * 10 + [2] * 5 + [3] * 2
table2 = spark.createDataFrame(id_values2, "int").toDF("id")

# table1.show()
# table2.show() # prints One 10 times, Two 5 times and Three twice

data = table1.join(table2, ["id"], "inner")

# print(data.count()) # 1000035

df_with_random = table1.withColumn("random_num", (1 + rand() * 10 ).cast("int")) # Generate random num from 1 to 10

table1 = df_with_random.withColumn("salted_key", concat(expr("id"), lit("_"), expr("random_num"))) # concat id_randomnum

"""
table1.show()
+---+----------+----------+
| id|random_num|salted_key|
+---+----------+----------+
|  1|         3|       1_3|
|  1|         9|       1_9|
|  1|         3|       1_3|
"""

table2_replicated = table2.withColumn("sequence", array([lit(i) for i in range(1, 11)])) 

table2 = table2_replicated\
    .withColumn("exploded_col", explode(col("sequence")))\
    .withColumn("salted_key", concat(expr("id"), lit("_"), expr("exploded_col")))\
    .drop("exploded_col", "sequence")

"""
table2.show()
+---+--------------------+------------+----------+
| id|            sequence|exploded_col|salted_key|
+---+--------------------+------------+----------+
|  1|[1, 2, 3, 4, 5, 6...|           1|       1_1|
|  1|[1, 2, 3, 4, 5, 6...|           2|       1_2|
|  1|[1, 2, 3, 4, 5, 6...|           3|       1_3|
"""

data = table1.join(table2, ["salted_key"], "inner")

data.count() # 1000035
