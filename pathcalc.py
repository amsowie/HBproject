
from geopy.distance import vincenty


class City(object):
    """City in graph of path options."""

    def __init__(self, city):
        self.city = city
        self.adjacent = set()

    def __repr__(self):
        return self.city

    def set_city_routes(self, city1, city2, miles):
        """Set two cities as adjacent"""
        #need tuples here for unpacking in Paths class
        city1.adjacent.add((city2, miles))
        city2.adjacent.add((city1, miles))

class Paths(object):
    """Directed graph of flights."""

    def __init__(self, cities):
        self.cities = cities

    def shortest(self, home):
        """Find the shortest path from home to every city.

        Returns dictionary of City: shortest-path.
        """

        # This uses "Dijkstra's algorithm" 
        # (read about it in a textbook)

        inf = float('inf')   # infinity

        # for each vertex of the graph, add an entry to the 
        # queue, with home having distance 0 and all 
        # others having infinite distance

        start = {vertex: 0 if vertex is home else inf for vertex in self.cities}
        queue = {vertex: (miles, vertex) for vertex, miles in start.items()}
        path = []  # map reachable v to its start[v] value

        while queue:
            # Remove the shortest path from the queue
            miles_in, m = queue.pop(sorted(queue.values())[0][1])
            #miles_in is weight of edge using distance

            # Save shortest city path from last node
            path.append(m)

            for vertex, dist in m.adjacent:  # unpack the city, dist tuple
                # Look for all possible routes that haven't been used yet
                if vertex not in set(path):
                    start[vertex] = dist
                    queue[vertex] = (start[vertex], vertex)

        return path

def create_nodes(cities, home):
    """Create nodes from node class for city graph"""

    cities.append(home)
    for city in cities:
        city_node = City(city)
        city_nodes.append(city_node)

    distance_calculation(cities)
    return city_nodes


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
atlanta = City("Atlanta")
oakland = City("Oakland")
la = City("LA")
selby = City("Selby")


places = Paths([atlanta, oakland, la, selby])

atlanta.set_city_routes(atlanta, oakland, 400)
selby.set_city_routes(selby, oakland, 500)
selby.set_city_routes(selby, atlanta, 150)
selby.set_city_routes(selby, la, 900)
oakland.set_city_routes(oakland, la, 200)
la.set_city_routes(la, atlanta, 250)


print "Best paths from {}".format(selby), places.shortest(selby)
