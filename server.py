"""Travel based on weather/time of year search."""

# from jinja2 import StrictUndefined
from flask import Flask, render_template, jsonify
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, City, Country, Weather, Month

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

    return render_template('search.html')

##############################################################################

if __name__ == "__main__":
    app.debug = True
    connect_to_db(app)
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")