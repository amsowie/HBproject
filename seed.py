"""Utility file to seed cities database"""

from model import City, Country, Month, Weather, connect_to_db, db
from server import app

def read_city_file():
    """Read city text from city file

    >>> cities = read_city_file()
    Cities
    >>> cities['Sao Paulo']
    ['Brazil', '-23.56288', '-46.654659']

    """

    print "Cities"
    # file open
    city_file = open("samplecities.txt")

    city_dict = {}

    for line in city_file:  # read in lines from file and store with city as key
        line = line.rstrip()
        country_name, city, latitude, longitude = line.split(",")
        city_dict[city] = [country_name, latitude, longitude]

    city_file.close()
    return city_dict


def write_citiesdb(city_dict):
    """ Write the cities from dictionary in read_city_file to database

    write_citiesdb({'Sao Paolo': [Brazil', '-23.56288', '-46.654659']})
    'Sao Paolo': [Brazil', '-23.56288', '-46.654659']

    """
    # instantiate objects of each city with values from dictionary
    for city in city_dict:
        dbcity = City(city_name=city,
                      country_name=city_dict[city][0],
                      city_lat=city_dict[city][1],
                      city_long=city_dict[city][2])
                      # ctry_id=ctry_id)

        db.session.add(dbcity)

    db.session.commit()

    print db.session.query.filter(City.city_name == 'Sao Paulo').all()


##############################################################################

if __name__ == '__main__':
    connect_to_db(app)
    db.create_all()

    city_dict = read_city_file()
    write_citiesdb(city_dict)
