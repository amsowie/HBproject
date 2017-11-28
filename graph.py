class CityNode(object):
    """Node in a graph representing a city."""

    def __init__(self, city, adjacent=None):
        """Create a city node with cities adjacent"""

        if adjacent is None:
            adjacent = {}

        assert isinstance(adjacent, dict), \
            "adjacent must be a dictionary!"

        self.city = city
        self.adjacent = adjacent

    def __repr__(self):
        """Debugging-friendly representation"""

        return "<CityNode: %s>" % self.city

class TripGraph(object):
    """Graph holding cities and their trip paths."""

    def __init__(self):
        """Create an empty graph"""

        self.nodes = set()

    def __repr__(self):
        return "<TripGraph: %s>" % [c.city for c in self.nodes]

    def add_city(self, city):
        """Add a city to the graph"""

        self.nodes.add(city)

    def set_city_routes(self, city1, city2, weight):
        """Set two cities as adjacent"""

        city1.adjacent[city1] = {city2: weight}
        city2.adjacent[city2] = {city1: weight}
