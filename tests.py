from unittest import TestCase
import doctest
from server import app

# Uncomment this if you want to run the doctests here too.

# def load_tests(loader, tests, ignore):
#     """Also run the doctests"""

#     tests.addTests(doctest.DocTestSuite(server))

#     return tests

class FlaskTests(TestCase):

    def setUp(self):
        """Set this up before every test"""

        self.client = app.test_client()
        app.config['TESTING'] = True  # shows debugging output

    # def tearDown(self):
    #     """After each test perform these steps"""
    #     # insert code to clear database here, but maybe in the next class
    #     db.session.close()
    #     db.drop_all()

    def test_index(self):
        """Test the homepage route"""

        result = self.client.get("/")
        self.assertEqual(result.status_code, 200)
        self.assertIn('Welcome', result.data)  # getting the data string back

    def test_search(self):
        """Test the search route"""

        result = self.client.get("/search")
        self.assertEqual(result.status_code, 200)
        self.assertIn('Month', result.data)  # is this actually the output to test?

class TestsDatabase(TestCase):

    def setUp(self):
        """Setting up the test database every time"""

        connect_to_db(app, "postgresql:///weather_travel") # work on this postg understanding and db test

        #create tables and ad sample data
        db.create_all()
        # samplecities.txt() What am I doing with this line????

    def tearDown(self):
        """Clear database at end of test"""

        db.session.close()
        db.drop_all()  # get rid of fake data

    def test_data_seed(self):
        """Test that the data seeded properly"""

        result = db.session.query


##############################################################################

if __name__ == "__main__":
    import unittest
    unittest.main()
