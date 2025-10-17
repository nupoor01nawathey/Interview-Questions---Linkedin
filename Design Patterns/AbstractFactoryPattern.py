"""
ABSTRACT FACTORY PATTERN

ABSTRACT SOURCES --> class Files(ABC), class RDBMS(ABC), class NoSQL(ABC), class DWH(ABC)
CONCRETE SOURCES --> class ParquetFile(Files), class DeltaFile(Files), class MySQL(RDBMS), class Hive(DWH)
ABSATRCT FACTORY --> class SourceFactory(ABC)
CONCRETE FACTORY --> class ParquetFileFactory(SourceFactory), class DeltaFileFactory(SourceFactory), class MySQLFactory(SourceFactory), class HiveFactory(SourceFactory)

Benefits of the Abstract Factory Pattern-
Consistency: The pattern enforces a consistent way of creating related objects, ensuring that they work seamlessly together.
Flexibility: Swapping between different families of objects is easy by using different concrete factories.
Scalability: Adding new families of objects involves creating new concrete factories and products, making the pattern extensible.
Decoupling: Client code remains decoupled from specific classes, allowing for easier maintenance and reducing dependencies.
"""

from abc import ABC, abstractmethod
from loguru import logger


# 1. Abstract Sources
class DWH(ABC):
    @abstractmethod
    def read(self):
        pass

class Files(ABC):
    @abstractmethod
    def read(self):
        pass

    @abstractmethod
    def transform(self):
        pass
            
class SQL(ABC):
    @abstractmethod
    def read(self):
        pass
            
# 2. Concrete classes for abstract sources
class Hive(DWH):
    def read(self):
        """
        Write code for Hive call
        """
        return "Reading from Hive(DWH) read()"

class Parquet(Files):
    def read(self):
        """
        Write code for Parquet read
        df = spark.read.parquet("to/file/path")
        return df
        """
        return "Reading from Parquet(Files) read()"
    
    def transform(self):
        pass

class CSV(Files):
    def read(self):
        """
        Write code for CSV read
        
        from pyspark.sql import SparkSession
        spark = SparkSession.builder.getOrCreatae()
        data = spark.read.option("inferSchema", "false").option("header", "false").csv("to/file/path")
        schema = StructType(StructField(
            "colname1", StringType,
            "colname2", Integertype,
            ...    
        ))
        df = spark.createDataFrame(data=data, schema=schema)
        return df
        """
        return "Reading from CSV(Files) read()"
    
    def transform(self):
        return "Transforming from CSV(Files) transform()"

class MySQL(SQL):
    def read(self):
        """
        Write code for Hive call
        """
        return "Reading from MySQL(SQL) read()"
    

# 3. Abstract Factories
class SourceFactory(ABC):
    @abstractmethod
    def read_from_hive(self):
        pass
    
    @abstractmethod
    def read_from_parquet(self):
        pass

    @abstractmethod
    def read_from_csv(self):
        pass
    
    @abstractmethod
    def read_from_mysql(self):
        pass

    @abstractmethod
    def transform_csv(self):
        pass

# 4. Concrete classes for abstract factories
class HiveFactory(SourceFactory):
    def read_from_hive(self):
        return Hive()
    
    def read_from_parquet(self):
        return None

    def read_from_csv(self):
        return None
    
    def read_from_mysql(self):
        return None
    
    def transform_csv(self):
        pass

class ParquetFactory(SourceFactory):
    def read_from_hive(self):
        return None
    
    def read_from_parquet(self):
        return Parquet()

    def read_from_csv(self):
        return None
    
    def read_from_mysql(self):
        return None  
    
    def transform_csv(self):
        pass


class CSVFactory(SourceFactory):
    def read_from_hive(self):
        return None
    
    def read_from_parquet(self):
        return None

    def read_from_csv(self):
        return CSV()

    def transform_csv(self):
        return CSV()
    
    def read_from_mysql(self):
        return None  
    
class MySQLFactory(SourceFactory):
    def read_from_hive(self):
        return None
    
    def read_from_parquet(self):
        return None

    def read_from_csv(self):
        return None
    
    def read_from_mysql(self):
        return MySQL()  
    
    def transform_csv(self):
        pass

factory_mapping = {
    "dwh": HiveFactory(),
    "parquet": ParquetFactory(),
    "csv": CSVFactory(),
    "mysql": MySQLFactory()
}


def read_from_source(source_name):
    factory = factory_mapping.get(source_name)
    if factory is None:
        raise ValueError(f"Invalid source_name {source_name} is provided")
    return factory

factory_parquet = read_from_source("parquet")
logger.info(factory_parquet.read_from_parquet().read())

factory_csv = read_from_source("csv")
logger.info(factory_csv.read_from_csv().read())
logger.info(factory_csv.transform_csv().transform()) ## Ideally for transform, create another abstract factory pattern , the current code violates single responsibility principle

####################################################################################################################################################################################

"""
ABSTRACT FACTORY PATTERN

ABSTRACT SOURCES --> class Laptop(ABC), class SmartPhone(ABC), class Tablet(ABC)
CONCRETE SOURCES --> class Dell(Laptop), class OnePlus(SmartPhone), class Samsung(Tablet)
ABSATRCT FACTORY --> class Factory(ABC)
CONCRETE FACTORY --> class DellFactory(Factory), class OnePlusFactory(Factory), class SamsungFactory(Factory)
"""

from abc import ABC, abstractmethod
from loguru import logger

# 1. Abstract Products/Sources
class Laptop(ABC):
    @abstractmethod
    def display(self):
        pass

class SmartPhone(ABC):
    @abstractmethod
    def display(self):
        pass

class Tablet(ABC):
    @abstractmethod
    def display(self):
        pass


# 2. Concrete Products/Sources
class DellLaptop(Laptop):
    def display(self):
        return "Dell Laptop Display from implemented class"

class OnePlus(SmartPhone):
    def display(self):
        return "OnePlus SmartPhone Display from implemented class"
    
class Samsung(Tablet):
    def display(self):
        return "Samsung Tablet Disaply from implemented class "


# 3. Abstract Fatory
class DeviceFactory(ABC):
    @abstractmethod
    def create_laptop(self):
        pass

    @abstractmethod
    def create_smartphone(self):
        pass

    @abstractmethod
    def create_tablet(self):
        pass

# 4. Concrete Factories
class DellFactory(DeviceFactory):
    def create_laptop(self):
        return DellLaptop()
    
    def create_smartphone(self):
        return None
    
    def create_tablet(self):
        return None
    

class OnePlusFactory(DeviceFactory):
    def create_laptop(self):
        return None
    
    def create_smartphone(self):
        return OnePlus()
    
    def create_tablet(self):
        return None 


class SamsungFactory(DeviceFactory):
    def create_laptop(self):
        return None

    def create_smartphone(self):
        return None 
    
    def create_tablet(self):
        return Samsung()
    

factory_mapping = {
    "dell": DellFactory(),
    "oneplus": OnePlusFactory(),
    "samsung": SamsungFactory()
}


def select_notification_factory(provider):
    factory = factory_mapping.get(provider)
    logger.info(f"Found factory: {factory}")
    if factory is None:
        raise ValueError("Invalid provider")
    return factory


factory = select_notification_factory("dell")

logger.info(factory.create_laptop().display())




