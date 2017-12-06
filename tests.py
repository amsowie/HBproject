from unittest import TestCase
import doctest
import bcrypt
import json
from flask import jsonify
from server import app
from model import City, Country, Weather, Month, User, Trip, connect_to_db, db, example_data

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

class TestUserLoggedInNoHometown(TestCase):

    def setUp(self):
        """Setting up tests for pages where user is logged in"""

        self.client = app.test_client()
        app.config['TESTING'] = True  # shows debugging output
        connect_to_db(app, "postgresql:///testdb")  # work on this postg understanding and db test
        app.config['SECRET_KEY'] = 'key'

        with self.client as c:
            with c.session_transaction() as sess:
                sess['user_name'] = 'Brian'
                sess['user_id'] = 1

        #create tables and ad sample data
        db.create_all()
        example_data()

    def tearDown(self):
        """Clear database at end of test"""

        db.session.close()
        db.drop_all()  # get rid of fake dat

    def test_save_searches(self):
        response = self.client.post("/save-searches", data={'cityId': 1,
                                                            'weatherId': 1,
                                                            'cityName': 'Santa Maria'})
        data = json.loads(response.get_data(as_text=True))
        self.assertIn(data['message'], "Hometown saved.")


class TestUserLoggedIn(TestCase):

    def setUp(self):
        """Setting up tests for pages where user is logged in"""

        self.client = app.test_client()
        app.config['TESTING'] = True  # shows debugging output
        connect_to_db(app, "postgresql:///testdb")  # work on this postg understanding and db test
        app.config['SECRET_KEY'] = 'key'

        with self.client as c:
            with c.session_transaction() as sess:
                sess['user_name'] = 'Brian'
                sess['user_id'] = 1
                sess['hometown'] = 2
                sess['hometown_name'] = 'Selby'

        #create tables and ad sample data
        db.create_all()
        example_data()

    def tearDown(self):
        """Clear database at end of test"""

        db.session.close()
        db.drop_all()  # get rid of fake data

    def test_index(self):
        """Test the homepage route"""

        result = self.client.get("/", data={'email': 'bb@bb.com',
                                                  'password': 'bestie'},
                                                   follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn('Weather', result.data)

    def test_user_login(self):
        """Test user page is visible with session"""

        #test correct password, successful login
        result = self.client.post("/login", data={'email': 'bb@bb.com',
                                                  'password': 'bestie'},
                                                   follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("Welcome,", result.data)

        # test hometown saves and outputs to screen
        result = self.client.post('/login', data={'email': 'bb@bb.com',
                                                  'password': 'bestie'},
                                                   follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn('Selby', result.data)

        # test incorrect password
        result = self.client.post("/login", data={'email': 'bb@bb.com',
                                                  'password': 'fail'},
                                                   follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("Password incorrect.", result.data)

        # test no user, redirect to registration page
        result = self.client.post("/login", data={'email': 'no@user',
                                                  'password': 'fail'},
                                                   follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("No user", result.data)

    def test_save_searches(self):
        """Test the searches save and print to screen"""

        response = self.client.post("/save-searches", data={'cityId': 1,
                                                            'weatherId': 1,
                                                            'cityName': 'Santa Maria'})
        data = json.loads(response.get_data(as_text=True))
        self.assertIn(data['message'], "City saved.")

    def test_delete_routes(self):
        """Test deleting cities from db works properly"""

        info = {'citiesChosen': [{'weatherId': '2', 'name': 'Selby'}]}
        send_data = json.dumps(info)
        response = self.client.post('/delete-cities', data={'json': send_data}, follow_redirects=True)
        data = json.loads(response.get_data(as_text=True))
        self.assertIn(data['message'], "Cities deleted")

    def test_lat_long_info(self):
        """Test the lat, long information comes back to plot on map correctly"""

        response = self.client.get("/lat-long.json", data={'month': 'January', },)
        data = json.loads(response.get_data(as_text=True))
        self.assertIn('user_month', data)

        # response = self.client.get("/lat-long.json", data={'month': 'January', },)
        # data = json.loads(response.get_data(as_text=True))
        # self.assertIn('Partly cloudy', data['lat_longs'])

    def test_calc_city_order(self):
        """Test the city order calculation"""

        cities = {'citiesChosen': [{'name': 'Santa Maria', 'lat': 12.123, 'lng': 56.789}]}
        send_cities = json.dumps(cities)
        response = self.client.post("/calc-city-order", data={'json': send_cities}, follow_redirects=True)
        data = json.loads(response.get_data(as_text=True))

        self.assertEqual(data, {'1': 'Selby', '0': 'Santa Maria'})

    def test_logout(self):
        """Test the logout function works"""

        result = self.client.get("/logout", follow_redirects=True)

        self.assertEqual(result.status_code, 200)
        self.assertIn("Logged out.", result.data)

class TestsDatabase(TestCase):

    def setUp(self):
        """Setting up the test database every time"""

        self.client = app.test_client()
        app.config['TESTING'] = True  # shows debugging output
        connect_to_db(app, "postgresql:///testdb")  

        #create tables and ad sample data
        db.create_all()
        example_data()

    def tearDown(self):
        """Clear database at end of test"""

        db.session.close()
        db.drop_all()  # get rid of fake data

    def test_registration(self):
        """Test the registration route"""

        result = self.client.get("/register")
        self.assertEqual(result.status_code, 200)
        self.assertIn('Registration Page', result.data)  # check the register form route


    def test_example_data(self):
        """Test the city data seeded correctly"""

        city = db.session.query(City).filter(City.city_name == 'Selby').first()
        self.assertEqual(city.city_name, 'Selby')

    def test_process_registration(self):
        """Test registration form process"""

        result = self.client.post("/register-verify", data={
                                                        'email': 'ham@let.com',
                                                        'password': 'tobeornot',
                                                        'firstname': 'Hamlet',
                                                        'lastname': 'Hammy'},
                                                        follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("Welcome, Hamlet", result.data)

##############################################################################

if __name__ == "__main__":
    import unittest
    unittest.main()
