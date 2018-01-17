
from geopy.distance import vincenty


class City(object):
    """City in graph of path options."""

    def __init__(self, city, lat, lng):
        self.city = city
        self.lat = lat
        self.lng = lng
        self.adjacent = set()

    def __repr__(self):  # pragma: no cover
        return self.city

    def set_distance(self, city2, miles):
        """Set two cities as adjacent"""
        #need tuples here for unpacking in Paths class
        self.adjacent.add((city2, miles))
        city2.adjacent.add((self, miles))

class Paths(object):
    """Undirected, weighted graph of cities."""

    def __init__(self, cities):
        self.cities = cities

    def shortest(self, home_name):
        """Find the shortest path from home to every city.

        """

        # This uses "Dijkstra's algorithm"

        inf = float('inf')   # infinity

        # for each vertex of the graph, add an entry to the
        # queue, with home having distance 0 and all
        # others having infinite distance

        start = {vertex: 0 if vertex.city == home_name else inf for vertex in self.cities}
        queue = {vertex: (miles, vertex) for vertex, miles in start.items()}
        path = []  # map reachable v to its start[v] value

        while queue:
            # Remove the shortest path from the queue
            # miles_in is weight of edge using distance
            # m is the vertex city
            # optimize later using priority queue instead of sort
            miles_in, m = queue.pop(sorted(queue.values())[0][1])

            # Save shortest city path from last node to list for return
            path.append(m)

            for vertex, dist in m.adjacent:  # unpack the city, dist tuple
                # Look for all possible routes that haven't been used yet
                # to add to queue and reset their edge distances
                if vertex not in set(path):
                    start[vertex] = dist
                    queue[vertex] = (dist, vertex)

        return path

def create_nodes(cities, home):
    """Create nodes from node class for city graph"""

    city_nodes = []

    # add hometown to the list of additional cities
    cities.append(home)

    # instantiate nodes passing in name, latitude, and longitude
    for city in cities:
        city_node = City(city['name'], city['lat'], city['lng'])
        # append list of all city nodes
        city_nodes.append(city_node)

    # call the distance calculator to find distance between cities
    distance_calculation(city_nodes)

    return city_nodes


def distance_calculation(cities):
    """Take in a list cities and determine the best route based
    on the shortest flight being last"""

    # loop through each city and set adjacency to all other cities in list
    # using the vincenty calculation and set_distance method on nodes
    for i in range(len(cities) - 1):
        city1 = cities[i]
        lat_lng1 = (city1.lat, city1.lng)
        for j in range(i + 1, len(cities)):
            city2 = cities[j]
            lat_lng2 = (city2.lat, city2.lng)
            distance = vincenty(lat_lng1, lat_lng2).miles
            city1.set_distance(city2, distance)

