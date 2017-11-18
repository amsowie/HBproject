"use strict";

let map;

function initMap() {
    let uluru = {lat: 41.90311, lng: 12.49576};
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 1,
      center: uluru
    });
    // let marker = new google.maps.Marker({
    //   position: uluru,
    //   map: map
    // });
    // makeMarkers(map);
}

function pickMonth() {

    // $('#pick-month').change(function (evt){
        let monthChosen = $('#pick-month').val();
        $('#month-title').text(monthChosen);
        $.post('/lat-long.json', {month: monthChosen}, function (results){
        let latLongs = results.lat_longs;
        makeMarkers(latLongs);


    });
   
    
}

function makeMarkers(latLongs){

            // let month = results.user_month;
            // find a way to clear the markers
            let city, marker, image;
            
            for (let key in latLongs) {
                city = latLongs[key];
                if (city.icon == 'clear-day') {
                    image = 'http://maps.google.com/mapfiles/kml/pal4/icon41.png';
                }
                else if (city.icon == 'partly-cloudy-day') {
                    image = 'http://maps.google.com/mapfiles/kml/pal4/icon42.png';
                }
                else if ((city.icon == 'cloudy') || (city.icon == 'fog')) {
                    image = 'http://maps.google.com/mapfiles/kml/pal4/icon21.png';
                }
                else if ((city.icon == 'rain') || (city.icon == 'sleet')) {
                    image = 'http://maps.google.com/mapfiles/kml/pal4/icon40.png';
                }
                else if (city.icon == 'snow') {
                    image = 'http://maps.google.com/mapfiles/kml/pal4/icon43.png';
                }
                else {
                    image = 'http://maps.google.com/mapfiles/kml/pal4/icon0.png';
                }
                if ('temp_high' > 80) {
                     marker = new google.maps.Marker({
                        position: new google.maps.LatLng(parseFloat(city.lat), parseFloat(city.lng)),
                        map: map,
                        title: city.temp_high,
                        icon: image
                    });
                }
    }           
}

$('#month-pick').on('submit', function (evt){
    evt.preventDefault();
    pickMonth();
});


