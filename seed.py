"""Utility file to seed cities database"""

from model import City, Country, Month, connect_to_db, db
from server import app
import requests
import json
import os
from datetime import datetime as dt

KEY = os.environ.get('DARKSKY_KEY')

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




def read_month_file():
    """Read in month file for data seeding, store as list of 3 letter code

    >>> month_list = read_month_file()
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

def read_date_file():
    """Read in list of dates from date file and store as list of lists

    >>> date_list = read_date_file()
    Dates

    >>> date_list[0]
    '2018, 01, 15'
    """

    print "Dates"
    date_file = open('Data/dates.txt')
    date_list = []

    for line in date_file:
        date = line.rstrip()
        date_list.append(date)

    date_file.close()

    return date_list


def write_month(month_list, date_list):
    """Write the iso string formatted dates and regular dates to table"""
    i = 0

    for month in month_list:
        date = date_list[i]
        date = dt.strptime(date, '%Y, %m, %d')  # convert to datetime object
        addmonth = Month(month=month,
                         date=date.isoformat())  # store in iso format
        i += 1
        db.session.add(addmonth)
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

def write_weatherdb(month_list):
    """Write weather database from json????????

    >>> forecast = requests.get("https://api.darksky.net/forecast/" + KEY + "/37.8267,-122.4233,1521010800?exclude=hourly,currently")
    "What???"
    >>> forecast.json()
    ['hello']
    """  # need serious hellp in this section!!!!

    citiesdb = db.session.query(City).all()
    times = db.session.query(Month).all()
    forecast = requests.get("https://api.darksky.net/forecast/" + KEY + "/37.8267,-122.4233,1521010800?exclude=hourly,currently")
    return forecast
    #code to parse out the actual json data goes here
    # for time in times: # use this!!!!

    # for month in month_list:
    #     for city_id in cities:
    #         weather = Weather(city_id=City.city_id,
    #                           month=time.month,
    #                           temp=temperature,
    #                           summary=summary,
    #                           icon=icon)  # where would i want to send this????


##############################################################################

if __name__ == '__main__':
    connect_to_db(app)
    db.create_all()

    countries = read_country_file()
    city_dict = read_city_file()
    month_list = read_month_file()
    date_list = read_date_file()
    write_countrydb(countries)
    write_citiesdb(city_dict, countries)
    write_month(month_list, date_list)
    # write_weatherdb(month_list)
