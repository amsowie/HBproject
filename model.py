"""Models and database functions for HB project"""

from flask import Flask
import bcrypt
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

##############################################################################
# Model definitions
class Country(db.Model):
    """Name of country and code"""

    __tablename__ = "countries"

    country_code = db.Column(db.String(3), nullable=False, primary_key=True)
    country_name = db.Column(db.String(50), nullable=False)

    def __repr__(self):
        """Useful printout of country object"""

        return "<Country country_code={} country_name=>".format(self.country_code,
                                                                self.country_name)


class City(db.Model):
    """Cities to display for user"""

    __tablename__ = "cities"

    # Storing city name, lat, long, three letter country for use in query
    city_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    city_name = db.Column(db.String(50), nullable=False)
    city_lat = db.Column(db.String(50), nullable=False)
    city_long = db.Column(db.String(50), nullable=False)
    country_code = db.Column(db.String(3), db.ForeignKey
                                           ('countries.country_code'),
                                            index=True,
                                            nullable=False)
    country = db.relationship('Country', backref="cities")

    def __repr__(self):
        """Useful printout of city object"""

        return "<City city_name={} country_code={} city_id={}>".format(
                                                             self.city_name,
                                                             self.country_code,
                                                             self.city_id)


class Weather(db.Model):
    """Temperature and summary by city and month"""

    __tablename__ = "all_weather"

    # help with foreign key assignment!!!
    weather_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    city_id = db.Column(db.Integer, db.ForeignKey('cities.city_id'),
                                                  index=True, nullable=False)
    month = db.Column(db.String(15), db.ForeignKey('months.month'),
                                                  index=True, nullable=False)
    temp_high = db.Column(db.Integer, nullable=False)
    temp_low = db.Column(db.Integer, nullable=False)
    # summary from data of daily conditions, ex. 'sunny and warm'
    summary = db.Column(db.String(100), nullable=False)
    #icon below helps identify pictogram
    icon = db.Column(db.String(50), nullable=False)

    # set relationshp between cities and weather objects
    city = db.relationship('City', backref='weathers')

    def __repr__(self):
        """Useful printout of weather object"""

        return """<Weather weather_id={} city_id={} month={}
                        temp={} summary={}>""".format(self.weather_id,
                                                     self.city_id,
                                                     self.month,
                                                     self.temp_high,
                                                     self.temp_low,
                                                     self.summary)

class Month(db.Model):
    """Month and iso formatted time storage for API weather prediction"""

    __tablename__ = "months"

    month = db.Column(db.String(15), primary_key=True)
    date = db.Column(db.String(30), nullable=False)

    def __repr__(self):
        """Useful printout of weather object"""

        return "<Month month={} date={}>".format(self.month, self.date)

class User(db.Model):
    """User data to store after login"""

    __tablename__ = "users"

    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    fname = db.Column(db.String(30), nullable=False)
    lname = db.Column(db.String(30), nullable=False)
    email = db.Column(db.String(40), nullable=False)
    password = db.Column(db.String(100), nullable=False)
    city_id = db.Column(db.Text, db.ForeignKey('cities.city_id'), nullable=True)

    trips = db.relationship('Trip', backref='user')
    hometown = db.relationship('City')

    def __repr__(self):
        """Useful printout of user object"""

        return "<User user_id={} fname={} lname={} email={}>".format(self.user_id,
                                                                     self.fname,
                                                                     self.lname,
                                                                     self.email)

class Trip(db.Model):
    """Trip information by specific user"""

    __tablename__ = "trips"

    trip_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    weather_id = db.Column(db.Integer, db.ForeignKey('all_weather.weather_id'),
                                                  index=True,nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'),
                                                  index=True,nullable=False)

    weather = db.relationship('Weather')

    def __repr__(self):
        """Useful printout of trip object"""
        
        return "<User trip_id={} weather_id={} user_id={}>".format(self.trip_id,
                                                                     self.weather_id,
                                                                     self.user_id)
                                                                     


##############################################################################
def example_data():
    """Test data samples for tests.py file to use in database"""

    fake_month1 = Month(month='January', date='2018, 01, 15')
    fake_month2 = Month(month='February', date='2018, 02, 15')
    city1 = City(city_name='Santa Maria', city_lat='12.123', city_long='56.789', country_code='SPA')
    city2 = City(city_name='Selby', city_lat='42.123', city_long='-96.789', country_code='USA')
    weather1 = Weather(city_id=1, month='January', temp_high=50, temp_low=40, summary='Parly cloudy', icon='Partly-cloudy')
    weather2 = Weather(city_id=2, month='February', temp_high=60, temp_low=55, summary='Parly sunny', icon='Partly-sunny')
    country1 = Country(country_code='USA', country_name='United States')
    country2 = Country(country_code='SPA', country_name='Spain')
    user1 = User(fname='Brian', lname='Beaman', email="bb@bb.com", password=bcrypt.hashpw('bestie', bcrypt.gensalt()))
    user2 = User(fname='Kari', lname='Baldwin', email="kb@kb.com", password=bcrypt.hashpw('hohoho', bcrypt.gensalt()))
    trip1 = Trip(city_id=1, user_id=1, month='January')
    trip2 = Trip(city_id=2, user_id=2, month='February')

    db.session.add_all([user1, user2, fake_month2, fake_month1, country1, country2])
    db.session.commit()
    db.session.add_all([city1, city2])
    db.session.commit()
    db.session.add_all([weather1, weather2, trip1, trip2])
    db.session.commit()

def connect_to_db(app, db_uri='postgresql:///weather_travel'):
    """Connect the database to our Flask app."""

    # Configure to use our PostgresSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    # app.config['SQLALCHEMY_ECHO'] = True
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app

    connect_to_db(app)
    print "Connected to DB."
