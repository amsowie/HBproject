"use strict";

let map;

function initMap() {
    let rome = {lat: 41.90311, lng: 12.49576};
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: rome
    });
    // let marker = new google.maps.Marker({
    //   position: uluru,
    //   map: map
    // });
    // makeMarkers(map);
}

function filterCities() {

    // $('#pick-month').change(function (evt){
        let monthChosen = $('#pick-month').val();
        $('#month-title').text(monthChosen);
        $.post('/lat-long.json', {month: monthChosen}, function (results){
        let latLongs = results.lat_longs;
        let region = $('#select-region').val();
        makeMarkers(latLongs);
        changeCenter(region);

    });
   
    
}

function makeMarkers(latLongs){

            // let month = results.user_month;
            // find a way to clear the markers
            let city, marker, image;
            
            for (let key in latLongs) {
                city = latLongs[key];

                if (city.tempHigh < 30) {
                    image = 'http://maps.google.com/mapfiles/ms/micons/lightblue.png';
                }
                else if ((city.tempHigh < 40) && (city.tempHigh >= 30)) {
                    image = 'http://maps.google.com/mapfiles/ms/micons/blue.png';
                }
                else if ((city.tempHigh < 50) && (city.tempHigh >= 40)) {
                    image = 'http://maps.google.com/mapfiles/ms/micons/green.png';
                }
                else if ((city.tempHigh < 60) && (city.tempHigh >= 50)) {
                    image = 'http://maps.google.com/mapfiles/ms/micons/yellow.png';
                }
                else if ((city.tempHigh < 70) && (city.tempHigh >= 60)) {
                    image = 'http://maps.google.com/mapfiles/ms/micons/orange.png';
                }
                else {
                    image = 'http://maps.google.com/mapfiles/ms/micons/red.png';
                }
                 marker = new google.maps.Marker({
                    position: new google.maps.LatLng(parseFloat(city.lat), parseFloat(city.lng)),
                    map: map,
                    title: (city.tempHigh.toString() + "," + city.cityName),
                    icon: image
                });
                
    }           
}

function changeCenter(region) {

    if (region == 'africa') {
        map.setCenter({lat: 12.1348, lng: 15.0557});
    }
    else if (region == 'asia') {
        map.setCenter({lat: 19.073212, lng: 72.854195});
    }
    else if (region == 'south-america') {
        map.setCenter({lat: -23.533773, lng: -46.625290});
    }
    else if (region == 'north-america') {
        map.setCenter({lat: 40.8258, lng: -96.681679});
    }
    else if (region == 'oceania') {
        map.setCenter({lat: -25.760321, lng: 122.805176});
    }
    else if (region == 'europe') {
        map.setCenter({lat: 52.237049, lng: 21.017532});
    }
    console.log(region);
    map.setZoom(3);

}

$('#filter-cities').on('submit', function (evt){
    evt.preventDefault();
    filterCities();
});


