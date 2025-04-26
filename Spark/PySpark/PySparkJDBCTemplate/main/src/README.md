│── pyspark-template/
│   ├── main/
│   │   ├── src/
│   │   │    ├── workflows/
|   |   |    |    ├── workflow.py
│   │   │    ├── factories/
|   |   |    |    ├── extractor.py
|   |   |    |    ├── merger.py
|   |   |    |    ├── loader.py
|   |   |    ├── config/
|   |   |    |    ├── config_file.ini
│   │   |    |    ├── db_script.sql
│   │   │    ├── utility/
│   │   |    |    ├── common_utils.py
│   │   │    ├── sources/
|   |   |    |    ├── oracle_extractor.py
|   |   |    |    ├── mysql_extractor.py
|   |   |    |    ├── parquet_extractor.py
|   |   |    |    ├── delta_extractor.py
│   │   ├── main.py
│── test/
│   ├── test_labour.py
│   ├── test_mistri.py
│   ├── test_homebuyer.py
│── requirements.txt
│── README.md
