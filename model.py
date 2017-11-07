"""Models and database functions for HB project"""


from flask_sqlalchemy import flask_sqlalchemy
from collections import defaultdict


db = flask_sqlalchemy

##############################################################################
# Model definitions


class City(db.Model):
    """Cities to display for user"""

    __tablename__ = "cities"

    # check the format of the lat and long should be string? Integer?
    city_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    city_name = db.Column(db.String(50), nullable=False)
    city_lat = db.Column(db.String(50), nullable=False)
    city_long = db.Column(db.String(50), nullable=False)
    ctry_code = db.Column(db.String(3), nullable=False)

    def __repr__(self):
        """Useful printout of city object"""

        return "<City city_name={} ctry_code={} city_id={}>".format(
                                                             self.city_name,
                                                             self.ctry_code,
                                                             self.city_id)


class Country(db.Model):
    """Name of country and code"""

    __tablename__ = "countries"

    ctry_code = db.Column(db.String(3), primary_key=True)
    ctry_name = db.Column(db.String(30), nullable=False)

    def __repr__(self):
        """Useful printout of country object"""

        return "<Country ctry_code={} ctry_name={}>".format(self.ctry_code,
                                                            self.ctry_name)


class Weather(db.Model):
    """Temperature and summary by city and month"""

    __tablename__ = "all_weather"

    # help with foreign key assignment!!!
    weather_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    city_id = db.Column(db.Integer, db.ForeignKey('cities.city_id'))
    month = db.Column(db.String(15), db.ForeignKey('months.month'))
    temp = db.Column(db.Integer, nullable=False)
    summary = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        """Useful printout of weather object"""

        return "<Weather weather_id={} city_id={} month={} \
                         temp={} summary={}>".format(self.weather_id,
                                                     self.city_id,
                                                     self.month,
                                                     self.temp,
                                                     self.summery)


class Month(db.Model):
    """Month name and id"""

    __tablename__ = "months"

    month_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    month = db.Column(db.String(15), nullable=False)

    def __repr__(self):
        """Useful printout of month object"""

        return "<Month month_id={} month={}>".format(self.month_id, self.month)

##############################################################################


def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our PostgresSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///ratings'
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
