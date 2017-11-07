"""Utility file to seed cities database"""

from model import City, connect_to_db, db
from server import app

def load_cities():
    """Load cities from city file"""

    print "Cities"

    for line in open("samplecities.txt"):  # might need to specifiy file differently
        line = line.rstrip()
        city, _, lat, lng, population, country_name, _, country_code, _, = line.split(",")
