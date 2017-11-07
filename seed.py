"""Utility file to seed cities database"""

from model import City, connect_to_db, db
from server import app

def load_cities():
    """Load cities from city file"""

    print "Cities"

    