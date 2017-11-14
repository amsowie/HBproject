"""Travel based on weather/time of year search."""
import sys
# from jinja2 import StrictUndefined
from flask import Flask, render_template, jsonify, request
from flask_debugtoolbar import DebugToolbarExtension
import requests

from model import connect_to_db, db, City, Country, Month, Weather

app = Flask(__name__)
app.secret_key = "Ahahahahahha!!!!!!"
# app.jinja_env.undefined = StrictUndefined

##############################################################################

# homepage with future login info
@app.route('/')
def index():
    """Welcome/home page"""

    return render_template('welcome.html')

# page to select month to display
@app.route('/search')
def display_search():
    """Show page with search form"""

    month_list = db.session.query(Month.month).all()

    return render_template('search.html', month_list=month_list)

@app.route('/display-weather')
def display_weather():
    """Show user weather information for month searched"""
    # Really unsure of the below code, especially the cities one.
    user_month = request.args.get('month')
    # summary = db.session.query(Weather.summary).filter(Weather.month == user_month).all()
    weathers = db.session.query(Weather).filter(Weather.month == user_month).all()

    return render_template('display.html',
                            weathers=weathers,
                            month=user_month)

##############################################################################

if __name__ == "__main__":
    app.debug = True
    connect_to_db(app)
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")