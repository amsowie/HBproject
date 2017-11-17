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
    console.log(map);
    makeMarkers(map);
}

function pickMonth(map){

    $('#month').change(function (evt){
        let monthChosen = $(this).val();
        $('#month-title').text(monthChosen);
        $.get('/lat-long.json', {month: monthChosen}, function (results){
        
        let latLongs = results.lat_longs;

        makeMarkers(map, latLongs);

    });
   
    });
}

function makeMarkers(map, latLongs){

            // let month = results.user_month;
            // find a way to clear the markers
            let city;

            for (let key in latLongs) {
                city = latLongs[key];
                console.log(map);

                let marker = new google.maps.Marker({
                    position: new google.maps.LatLng(city.lat, city.lng),
                    map: map,
                    title: city.city_name
                });
}
