"""Utility file to seed cities database"""

# from model import City, connect_to_db, db
# from server import app

def load_cities():
    """Load cities from city file

    >>> load_cities()
    Cities
    ['Brazil', '-23.56288', '-46.654659']

    """

    print "Cities"
    # file open 
    city_file = open("samplecities.txt")

    city_dict = {}

    for line in city_file:  # split data and store in dictionary by city
        line = line.rstrip()
        country_name, city, latitude, longitude = line.split(",")
        city_dict[city] = [country_name, latitude, longitude]

    print city_dict['Sao Paulo']
    city_file.close()
