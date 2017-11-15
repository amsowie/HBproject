from unittest import TestCase
import doctest
from server import app
from model import City, Country, Weather, Month, connect_to_db, db, example_data

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

    def test_index(self):
        """Test the homepage route"""

        result = self.client.get("/")
        self.assertEqual(result.status_code, 200)
        self.assertIn('Log In', result.data)  # getting the data string back

    def test_login_page(self):

        result = self.client.get("/login")
        self.assertEqual(result.status_code, 200)
        self.assertIn('Email:', result.data)

    def test_user_page(self):

        result = self.client.get("/user-page")
        self.assertEqual(result.status_code, 200)
        self.assertIn("Welcome back", result.data)

class TestUserLoggedIn(TestCase):

    def setUp(self):
        """Setting up tests for pages where user is logged in"""

        self.client = app.test_client()
        app.config['TESTING'] = True  # shows debugging output
        connect_to_db(app, "postgresql:///testdb")  # work on this postg understanding and db test
        app.config['SECRET_KEY'] = 'key'

        with self.client as c:
            with c.session_transaction() as sess:
                sess['user_id'] = 1

        #create tables and ad sample data
        db.create_all()
        example_data()

class TestsDatabase(TestCase):

    def setUp(self):
        """Setting up the test database every time"""

        self.client = app.test_client()
        app.config['TESTING'] = True  # shows debugging output
        connect_to_db(app, "postgresql:///testdb")  # work on this postg understanding and db test

        #create tables and ad sample data
        db.create_all()
        example_data()

    def tearDown(self):
        """Clear database at end of test"""

        db.session.close()
        db.drop_all()  # get rid of fake data

    def test_display_weather(self):
        """Test the display weather route"""

        result = self.client.get("/display-weather")
        self.assertEqual(result.status_code, 200)
        self.assertIn('Display Weather', result.data)  # check the display route

    def test_search(self):
        """Test the search route"""

        result = self.client.get("/search")
        self.assertEqual(result.status_code, 200)
        self.assertIn('February', result.data)  # is this actually the output to test?

    def test_example_data(self):
        """Test the city data seeded correctly"""

        city = db.session.query(City).filter(City.city_name == 'Selby').first()
        self.assertEqual(city.city_name, 'Selby')


##############################################################################

if __name__ == "__main__":
    import unittest
    unittest.main()
