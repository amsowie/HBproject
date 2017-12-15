

About

Weather to Wander is a travel planning app that uses weather data from the
Dark Sky API and Google maps to provide monthly weather predictions for world 
cities. It also provides a route planning tool that calculates the best path
prioritizing the last leg as the shortest route home in a multi-city vacation. I
built it because I wanted users to be able to decide where to vacation based on
weather without having to cross reference multiple websites. Planning a multi-city
vacation can be complicated. It's difficult to decide on a route, but this app
makes that easier. The last flight is always the most miserable, so I minimized 
user suffering by making certain it would be as short as possible.

Installation

To use locally:
Make a directory.
Clone repository.
Create a virtual env.
Source secrets.
Pip install requirements.
Run python server.py
Go to your local host to view the app.

Features

Users register and their password is hashed and then stored in the database. They
also save their hometown to their profile. They can filter searches by world
region, month, or both in order to view city specific weather data. Clicking
on a city marker will reveal an info window with additional details and gives
users the option to save the city to their vacation planner. The vacation planner
will calculate a a route home, guaranteeing the last leg is the shortest. This
app has 98% test coverage of the backend and was developed using test driven
development.

Tech Stack

Flask, PostgreSQL, JQuery, SQLAlchemy, bcrypt, JSON, geopy, HTML, CSS, 
Bootstrap, Python, AJAX, Jinja

Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

Author

I am a former athlete turned developer who is passionate about test driven 
development and the study of algorithms.

