    val rdd = spark.range(100000)
    println(rdd.queryExecution.optimizedPlan.stats.sizeInBytes) // 800000 / 8 Long type size in bytes => yields original range 100000, doesn't work on df.rdd
