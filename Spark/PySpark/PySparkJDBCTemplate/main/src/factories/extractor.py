from loguru import logger
import configparser
from sources.oracle_extractor import OracleExtractor

class Extractor:
    def __init__(self, params):
        logger.info("Setting params in Extractor __init__")
        self.source_type = params.get("source_type")
        self.table_name = params.get("table_name")
        self.oracle_db_config = self.__extract_oracle_db_info()
        self.watermark_date = self.__extract_watermark_date(self.table_name)
        c = configparser.ConfigParser()
        # self.table_config = c.read(r"path/to/table/config.ini")
        self.table_config = r"path/to/table/config.ini"

    def __extract_oracle_db_info(self):
        logger.info("Setting oracle db info")
        server = "oraclesever"
        port = 1521
        service_name = 'ORCL'
        return {
            "driver": "oracle.jdbc.driver.OracleDriver",
            "jdbc_url": f"jdbc:oracle:thin@{server}:{port}:{service_name}",
            "user": "user",
            "password": "password" # encrypt password and use here as decrypt(password)
        }

    def __extract_watermark_date(self, table_name):
        logger.info("Extracting watermark date")
        # df = spark.read.format("parquet").load("path/to/table/watermark")
        # Returns value of First Row, First Column which is "watermark_date"
        # watermark_date = df.collect()[0][0]
        watermark_date = "2025-01-01 00:00:00"
        return watermark_date

    def runner(self):
        # 1. Extract from req source
        if self.source_type == "oracle":
            logger.info("Calling OracleExtractor extract")
            return OracleExtractor().extract(
                self.oracle_db_config, 
                self.table_config, 
                self.watermark_date
            ) #todo pass "config.ini" here later
        

