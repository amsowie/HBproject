from geopy.distance import vincenty

def distance_calculation(cities, home):
    """Take in a list of four cities or less and determine the best route based
    on the shortest flight being last"""

    cities.append(home)
    for i in range(len(cities) - 1):
        for j in range(1, len(cities)):
            city1 = (city[i].lat, city[i].long)
            city2 = (city[j].lat, city[j].long)
            distance = (vincenty(city1, city2.miles) # save this truncated later
        

        # city[i] = City(city[i])

        city[i].set_city_routes(city[i], city[j], distance)


