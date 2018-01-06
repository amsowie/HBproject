"""Utility file to seed cities database"""

from model import City, Country, Month, Weather, User, Trip, connect_to_db, db
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
    city_file = open("Data/CityData.txt")

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
    ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

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
        city_table = City(city_name=city,
                      country_code=countries[city_dict[city][0]],  # three letter country code
                      city_lat=city_dict[city][1],
                      city_long=city_dict[city][2])
        db.session.add(city_table)

    db.session.commit() 

def write_weatherdb():
    """Write weather database from json from Darsky API

    >>> forecast = requests.get("https://api.darksky.net/forecast/" + KEY + "/37.8267,-122.4233,1521010800?exclude=hourly,currently")
    >>> forecast = forecast.json()
    >>> day = forecast['daily']
    >>> day_data = day['data'][0]
    >>> summary = day_data['summary']
    >>> print summary
    Partly cloudy throughout the day.

    """
    cities_from_table = db.session.query(City).all()  # use city and month tables to set up get request below
    times_from_table = db.session.query(Month).all()

    for city in cities_from_table:
        try:
            if ((city.city_id < 265) and (city.city_id > 244)):
                for time in times_from_table:
                    forecast = requests.get("https://api.darksky.net/forecast/" + KEY + "/" + city.city_lat + ", " + city.city_long + ", " + time.date + "?exclude=hourly,currently")
                    forecast = forecast.json()  # save the usable dictionary object to variable

                    #filter out cities without weather information
                    if 'daily' in forecast:

                        full_day = forecast['daily']  # the full json inlcuding lat,long,city
                        day_data = full_day['data'][0]   # getting just the weather info out of list
                        icon = day_data['icon']         # the computer/predictible icon description ex. partly-cloudy
                        summary = day_data['summary']   # human readable summary, 'Partly sunny all day'
                        temp_high = day_data['temperatureHigh']
                        temp_low = day_data['temperatureLow']

                        weather = Weather(city_id=city.city_id,
                                          month=time.month,
                                          temp_high=temp_high,
                                          temp_low=temp_low,
                                          summary=summary,
                                          icon=icon)
                        db.session.add(weather)
                    else:
                        break  # get out of the months loop if there's no data for January
                    # add logic here to prevent the twelve month cycle for each city without weather
        except:
            print city
    db.session.commit()


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
    write_weatherdb()
