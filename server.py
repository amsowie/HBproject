"""Travel based on weather/time of year search."""
import sys
import bcrypt
# from jinja2 import StrictUndefined
from flask import Flask, render_template, jsonify, request, session, redirect, flash
from flask_debugtoolbar import DebugToolbarExtension
import requests

from model import connect_to_db, db, City, Country, Month, Weather, User, Trip
app = Flask(__name__)
app.secret_key = "Ahahahahahha!!!!!!"
# app.jinja_env.undefined = StrictUndefined

##############################################################################

# homepage with future login info
@app.route('/')
def index():
    """Welcome/home page"""

    return render_template('welcome.html')

@app.route('/login')
def login():
    """Show login form to user"""

    return render_template('login.html')

@app.route('/login', methods=['POST'])
def user_login():
    """Process log in"""

    email = request.form.get('email')
    password = request.form.get('password')

    user = db.session.query(User).filter(User.email == email).first()

    if user and not (bcrypt.hashpw(password.encode('utf-8'), user.password.encode('utf-8')) == user.password):
        flash("Password incorrect. Please try again.")
        return redirect('/login')
    elif user:
        session['user_name'] = user.fname
        return redirect('/map')
    else:
        flash("No user exists with that information. Please register.")
        return redirect('/register')

@app.route('/register')
def register():
    """Show registration form"""

    return render_template('register.html')

@app.route('/register-verify', methods=['POST'])
def process_registration():
    """Process registration information"""

    fname = request.form.get('firstname')
    lname = request.form.get('lastname')
    email = request.form.get('email')
    password = request.form.get('password')  # hash this later for storage

    hashed_pass = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    user = User(fname=fname, lname=lname, email=email, password=hashed_pass)

    db.session.add(user)
    db.session.commit()

    session['user_name'] = fname

    flash("Thank you for registering")

    return redirect('/map')

# page to select month to display
# @app.route('/search')
# def display_search():
#     """Show page with search form"""

#     month_list = db.session.query(Month.month).all()

#     return render_template('search.html', month_list=month_list)

# @app.route('/display-weather')
# def display_weather():
#     """Show user weather information for month searched"""

    # get the value from months dropdown menu

    # summary = db.session.query(Weather.summary).filter(Weather.month == user_month).all()

    # return render_template('display.html',
    #                         weathers=weathers,
    #                         month=user_month)



@app.route('/lat-long.json', methods=['POST'])
def lat_long_info():
    """Return lat_long information to plot cities on map"""

    lat_longs = {}

    user_month = request.form.get('month')
    # weathers = db.session.query(Weather).all()
    weathers = db.session.query(Weather).filter(Weather.month == user_month).all()
    for weather in weathers:
            lat_longs[weather.city.city_name] = {'lat': weather.city.city_lat,
                                                 'lng': weather.city.city_long,
                                                 'summary': weather.summary,
                                                 'icon': weather.icon,
                                                 'temp_high': weather.temp_high,
                                                 'temp_low': weather.temp_low,
                                                 'city_name': weather.city.city_name}
    data = {}
    data["lat_longs"] = lat_longs
    data["user_month"] = user_month

    return jsonify(data)

@app.route('/map')
def map():
    """Map page"""

    month_list = db.session.query(Month.month).all()

    return render_template('weathermap.html', month_list=month_list)

@app.route('/logout')
def log_out():
    """Log user out and delete session"""

    del session['user_name']

    flash("Logged out.")

    return redirect('/')
##############################################################################

if __name__ == "__main__":  # will connect to db if you run python server.py
    app.debug = True        # won't run in testy.py because it's not server.py
    connect_to_db(app)
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")