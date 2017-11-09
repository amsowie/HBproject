"""Models and database functions for HB project"""

from flask import Flask
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

    # check the format of the lat and long should be string? Integer?
    city_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    city_name = db.Column(db.String(50), nullable=False)
    city_lat = db.Column(db.String(50), nullable=False)
    city_long = db.Column(db.String(50), nullable=False)
    country_code = db.Column(db.String(3), db.ForeignKey
                                           ('countries.country_code'),
                                            index=True,
                                            nullable=False)

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
    city_id = db.Column(db.Integer, db.ForeignKey
                                 ('cities.city_id'), index=True, nullable=False)
    month = db.Column(db.String(3), nullable=False)
    temp = db.Column(db.Integer, nullable=False)
    # summary from data of daily conditions, ex. 'sunny and warm'
    summary = db.Column(db.String(100), nullable=False)

    # set relationshp between cities and weather objects
    city = db.relationship('City', backref='all_weather')

    def __repr__(self):
        """Useful printout of weather object"""

        return "<Weather weather_id={} city_id={} month={} \
                         temp={} summary={}>".format(self.weather_id,
                                                     self.city_id,
                                                     self.month,
                                                     self.temp,
                                                     self.summary)



##############################################################################


def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our PostgresSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///weather_travel'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_ECHO'] = True
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app

    connect_to_db(app)
    print "Connected to DB."
