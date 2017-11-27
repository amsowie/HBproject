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
    if 'user_name' in session:
        return redirect('/map')
    else:
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
        session['user_id'] = user.user_id
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

    user_id = user.user_id

    session['user_name'] = fname
    session['user_id'] = user_id

    flash("Thank you for registering")

    return redirect('/map')

@app.route('/save-searches', methods=['POST'])
def save_searches():
    """Save searches the user selects to the database for future display"""

    city_id = request.form.get('cityId')
    month = request.form.get('monthChosen')
    summary = request.form.get('summary')
    temp_high = request.form.get('tempHigh')
    temp_low = request.form.get('tempLow')
    user_id = session['user_id']


    #this will need to be a query for other things, maybe include weather?
    data = db.session.query(City).filter(City.city_id == city_id).first()
    city_name = data.city_name
    trip = Trip(city_id=city_id, user_id=user_id, month=month)

    db.session.add(trip)
    db.session.commit()

    info = {'cityId': data.city_id,
            'monthChosen': month,
            'tempHigh': temp_high,
            'tempLow': temp_low,
            'summary': summary,
            'cityName': city_name}  # trial lines

    return jsonify(info)

# @app.route('/plan-trip')
# def plant_trip():
#     """Take in user's saved trip cities and determine best route based on
#     length of flight"""

#     let cities_to_calculate = request.form.get()

@app.route('/lat-long.json', methods=['GET'])
def lat_long_info():
    """Return lat_long information to plot cities on map"""

    lat_longs = {}

    user_month = request.args.get('month')
    weathers = db.session.query(Weather).filter(Weather.month == user_month).all()
    for weather in weathers:
            lat_longs[weather.city.city_name] = {'lat': weather.city.city_lat,
                                                 'lng': weather.city.city_long,
                                                 'wSummary': weather.summary,
                                                 'icon': weather.icon,
                                                 'tempHigh': weather.temp_high,
                                                 'tempLow': weather.temp_low,
                                                 'cityName': weather.city.city_name,
                                                 'cityId': weather.city.city_id}
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
    del session['user_id']

    flash("Logged out.")

    return redirect('/')
##############################################################################

if __name__ == "__main__":  # will connect to db if you run python server.py
    app.debug = True        # won't run in testy.py because it's not server.py
    connect_to_db(app)
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")