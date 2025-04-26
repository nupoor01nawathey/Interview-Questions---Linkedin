from loguru import logger
from workflows.workflow import WorkFlowType

def main():
    logger.info("Inside main() calling WorkFlowType runner")

    # for data lake, should be passed in the input itself and later extract in Spark Job
    # for time being create dict for imput args/params
    params = {
        "activity_type": "extractor",
        "source_type": "oracle",
        "table_name": "emp"
    }
    runner = WorkFlowType(params).runner() 

    # activity_type = "merge" # for delta lake


if __name__ == "__main__":
    logger.info("Going to main()")
    main()

