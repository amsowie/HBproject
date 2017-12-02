"""Travel based on weather/time of year search."""
import sys
import json
import bcrypt
# from jinja2 import StrictUndefined
from flask import Flask, render_template, jsonify, request, session, redirect, flash
from flask_debugtoolbar import DebugToolbarExtension
import requests
from pathcalc import City, Paths, create_nodes, distance_calculation

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
        if user.hometown:
            session['hometown'] = user.hometown.city_id
            session['hometown_name'] = user.hometown.city_name
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

    weather_id = request.form.get('weatherId')
    city_id = request.form.get('cityId')
    city_name = request.form.get('cityName')
    user_id = session['user_id']

    if 'hometown' in session:
        trip = Trip(weather_id=weather_id, user_id=user_id)

        db.session.add(trip)
        db.session.commit()
        message = "City saved."
    else:
        user = db.session.query(User).filter(User.user_id == user_id).first()
        user.city_id = city_id
        db.session.commit()
        session['hometown'] = city_id
        session['hometown_name'] = city_name
        message = "Departure city saved."

    return jsonify(message=message)



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
                                                 'cityId': weather.city.city_id,
                                                 'weatherId': weather.weather_id}
    data = {}
    data["lat_longs"] = lat_longs
    data["user_month"] = user_month

    return jsonify(data)

@app.route('/map')
def map():
    """Map page"""
    user_id = session['user_id']
    month_list = db.session.query(Month.month).all()
    weathers = db.session.query(Trip).filter(Trip.user_id == user_id).all()

    return render_template('weathermap.html', month_list=month_list, weathers=weathers)

@app.route('/calc-city-order', methods=['POST'])
def calc_city_order():
    """Use functions to add cities as nodes in graph for use with Dijkstra's
    algorithm to return order of cities"""

    home = {}
    form_JSON = request.form.get('json')
    form_data = json.loads(form_JSON)  # turns back to dictionary
    cities_for_trip = form_data.get('citiesChosen')
    hometown = session['hometown_name']

    home_obj = db.session.query(City).filter(City.city_name == hometown).first()
    print home_obj
    home['name'] = home_obj.city_name
    home['lat'] = home_obj.city_lat
    home['lng'] = home_obj.city_long

    city_nodes = create_nodes(cities_for_trip, home)
    route_plan = Paths(city_nodes)
    trip_routes = route_plan.shortest(home["name"])[::-1]
    order = {}
    print "here"

    for i in range(len(trip_routes)):
        order[i] = trip_routes[i].city

    print order
    return jsonify(order)


@app.route('/delete-cities', methods=['POST'])
def delete_routes():
    """Delete cities from checkboxes"""

    form_JSON = request.form.get('json')
    form_data = json.loads(form_JSON)
    cities_to_delete = form_data.get('citiesChosen')
    print cities_to_delete

    for i in range(len(cities_to_delete)):
        weather_id = cities_to_delete[i]['weatherId']
        db.session.query(Trip).filter(Trip.weather_id == weather_id).delete()
        db.session.commit()

    return jsonify(message="Cities deleted")

@app.route('/logout')
def log_out():
    """Log user out and delete session"""

    del session['user_id']
    del session['user_name']
    if 'hometown' in session:
        del session['hometown']
        del session['hometown_name']

    flash("Logged out.")

    return redirect('/')
##############################################################################

if __name__ == "__main__":  # will connect to db if you run python server.py
    app.debug = True        # won't run in testy.py because it's not server.py
    connect_to_db(app)
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")