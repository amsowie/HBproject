"use strict";

function initMap() {
    let uluru = {lat: -25.363, lng: 131.044};
    let map = new google.maps.Map(document.getElementById('map'), {
      zoom: 1,
      center: uluru
    });
    let marker = new google.maps.Marker({
      position: uluru,
      map: map
    });
}
$.get('/lat-long.json', function (lat_longs){

    let city;

    for (let key in lat_longs) {
        city = lat_longs[key];

        let marker = new google.maps.Marker({
            position: new google.maps.LatLng(city.lat, city.lng),
            map: map,
            title: 'Here!'
        });
    }
});