"""Travel based on weather/time of year search."""

# from jinja2 import StrictUndefined
from flask import Flask, render_template, jsonify
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, City, Country, Month

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
    # summary = db.session.query(Weather.summary).filter(Weather.month == 'user_month')
    # temp = db.session.query(Weather.temp).filter(Weather.month == 'user_month')
    # icon = db.session.query(Weather.icon).filter(Weather.month == 'user_month')
    # cities = db.session.query(all_weather.city_name).filter(Weather.month == 'user_month')

    return render_template('display.html')
                            # summary=summery,
                            # temp=temp,
                            # icon=icon)

##############################################################################

if __name__ == "__main__":
    app.debug = True
    connect_to_db(app)
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")