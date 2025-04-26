from loguru import logger

class BaseExtractor:
    def __init__(self):
        pass

    def extract(self):
        pass


class OracleExtractor(BaseExtractor):
    def extract(self, db_config, table_config, watermark_date):
        """
        params is a dict type specifying table specific params
        do error handling as these are req params
        https://spark.apache.org/docs/latest/sql-data-sources-jdbc.html
        """
        # current_ts = current_time()
        # return (
        #     spark.read.format("jdbc")\
        #         .option("url", db_config.get("jdbc_url")) \
        #         .option("user", db_config.get("user")) \
        #         .option("password", db_config.get("password")) \
        #         .option("driver", db_config.get("driver")) \
        #         .option("dbtable", self.table_config.get("table_name")) \
        #         .option("fetchSize", 10000) \
        #         .option("numPartitions", self.table_config.get("numPartitions")) \
        #         .option("partitionColumn", self.table_config.get("primary_key")) \
        #         .option("lowerBound", watermark_date) \
        #         .option("upperbound", current_ts)       
        #         .load()
        # )
        
        logger.info("Retuning from OracleExtractor Extract, this should return extracted data")



"""
    df = extract_from_source(
        type="oracle",
        driver="oracle-jdbc-driver",
        url="url",
        port="port",
        username="username",
        password="password",
        dbname="dbname"
        params={"param1": "val1", "param2": "val2"}
    )
    return df
"""        
