import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    logger.info("Secure application Lambda function executed successfully")

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Hello from Secure AWS Application Infrastructure!",
            "status": "success"
        })
    }
