"""Utility file to seed cities database"""

from model import City, Country, Weather, connect_to_db, db
from server import app
import json
import os

def read_city_file():
    """Read city text from city file

    >>> cities = read_city_file()
    Cities
    >>> cities['Sao Paulo']
    ['Brazil', '-23.56288', '-46.654659']

    """
    print "Cities"
    # file open
    city_file = open("Data/samplecities.txt")

    city_dict = {}

    for line in city_file:  # read in lines from file and store with city as key
        line = line.rstrip()
        country_name, city, latitude, longitude = line.split(",")
        city_dict[city] = [country_name, latitude, longitude]

    city_file.close()
    return city_dict

def read_country_file():
    """Read in country name and code from file

    >>> countries = read_country_file()
    Countries

    >>> countries['Brazil']
    'BRA'
    """

    country_file = open('Data/CountryCodes.txt')

    print "Countries"
    countries = {}

    for line in country_file:
        line = line.rstrip()
        country_code = line[:3]  # first three letters are code
        country_name = line[4:]  # rest of line is country name
        countries[country_name] = country_code

    country_file.close()

    return countries  # dictionary with key of country name, value country code


def write_countrydb(countries):
    """Write country names and codes to database using countries dictionary"""

    for country in countries:
        dbcountry = Country(country_code=countries[country],
                            country_name=country)

        db.session.add(dbcountry)

    db.session.commit()

def write_citiesdb(city_dict, countries):
    """ Write the cities from dictionary in read_city_file to database

    write_citiesdb({'Sao Paolo': [Brazil', '-23.56288', '-46.654659']})
    'Sao Paolo': [Brazil', '-23.56288', '-46.654659']

    """
    # instantiate objects of each city with values from dictionary
    for city in city_dict:
        dbcity = City(city_name=city,
                      country_code=countries[city_dict[city][0]],
                      city_lat=city_dict[city][1],
                      city_long=city_dict[city][2])
        db.session.add(dbcity)

    db.session.commit()


def read_month_file():
    """Read in month file for data seeding, store as list of 3 letter code

    >>> month_list = write_weatherdb()
    Months

    >>> month_list
    ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

    """

    print 'Months'

    month_file = open('Data/months.txt')
    month_list = []  # use this list to write the months out in loops???

    for line in month_file:
        line = line.rstrip()
        month_list.append(line)

    month_file.close()

    return month_list

def write_weatherdb(month_list):
    """Write weather database from json????????"""

    results = requests.get() # put the api stuff in these parens
    weather_data = results.json()
##############################################################################

if __name__ == '__main__':
    connect_to_db(app)
    db.create_all()

    month_list = write_weatherdb()
    countries = read_country_file()
    city_dict = read_city_file()
    write_countrydb(countries)
    write_citiesdb(city_dict, countries)
    write_weatherdb(month_list)
