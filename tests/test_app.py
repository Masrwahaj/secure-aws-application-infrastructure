import importlib.util
import json
import os
import unittest

APP_PATH = os.path.join(
    os.path.dirname(os.path.dirname(__file__)),
    "lambda",
    "app.py"
)

SPEC = importlib.util.spec_from_file_location("lambda_app", APP_PATH)
APP = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(APP)

lambda_handler = APP.lambda_handler


class TestLambdaHandler(unittest.TestCase):

    def test_successful_response(self):
        response = lambda_handler({}, None)

        self.assertEqual(response["statusCode"], 200)

        body = json.loads(response["body"])
        self.assertEqual(
            body["message"],
            "Hello from Secure AWS Application Infrastructure!"
        )
        self.assertEqual(body["status"], "success")


if __name__ == "__main__":
    unittest.main()
