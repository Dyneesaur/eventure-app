import server
import unittest
import json
import base64
from pymongo import MongoClient

db = None


class FlaskrTestCase(unittest.TestCase):

    def setUp(self):
        self.app = server.app.test_client()
        # Run app in testing mode to retrieve exceptions and stack traces
        server.app.config['TESTING'] = True

        # Inject test database into application
        mongo = MongoClient('localhost', 27017)
        global db
        db = mongo.test_database
        server.app.db = db

        # Reduce encryption workloads for tests
        server.app.bcrypt_rounds = 4

        
        db.drop_collection('users')

        # Drop collection (significantly faster than dropping entire db)
        self.app.post('/user/',
                      data=json.dumps(dict(
                          username="user",
                          password="password"
                      )),
                      content_type='application/json')

    # User tests

    def test_signup_with_username_and_password(self):
        response = self.app.post('/user/',
                                 data=json.dumps(dict(
                                     username="benjamin",
                                     password="test"
                                 )),
                                 content_type='application/json')

        json.loads(response.data.decode())

        self.assertEqual(response.status_code, 200)

    def test_verifying_credentials(self):
        self.app.post('/user/',
                      data=json.dumps(dict(
                          username="benjamin",
                          password="test"
                      )),
                      content_type='application/json')

        response = self.app.get('/user/',
                                headers=self.default_auth_header()
                                )

        self.assertEqual(response.status_code, 200)

    def test_incorrect_credentials(self):
        response = self.app.get('/user/',
                                headers=self.generate_auth_header(
                                    'wrongusername', 'andpassword')
                                )

        self.assertEqual(response.status_code, 401)
    

    def default_auth_header(self):
        return self.generate_auth_header("user", "password")

    def generate_auth_header(self, username, password):
        authString = username + ":" + password
        return {'Authorization': 'Basic ' +
                base64.b64encode(authString.encode('utf-8')).decode('utf-8')}

if __name__ == '__main__':
    unittest.main()