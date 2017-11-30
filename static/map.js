"use strict";

let map;
var allMarkers = [];
let prevInfoWindow = false;
let iconImages = {
                LBlue: {name: 'Below 30F', icon: 'http://maps.google.com/mapfiles/ms/micons/lightblue.png'},
                Blue: {name: '30-40F', icon: 'http://maps.google.com/mapfiles/ms/micons/blue.png'},
                Green: {name: '41-50F', icon: 'http://maps.google.com/mapfiles/ms/micons/green.png'},
                Yellow: {name: '51-60F', icon: 'http://maps.google.com/mapfiles/ms/micons/yellow.png'},
                Orange: {name: '61-70F', icon: 'http://maps.google.com/mapfiles/ms/micons/orange.png'},
                Pink: {name: '71-80F', icon: 'http://maps.google.com/mapfiles/ms/micons/pink.png'},
                Red: {name: 'Above 80F', icon: 'http://maps.google.com/mapfiles/ms/micons/red.png'}};

function initMap() {
    let rome = {lat: 41.90311, lng: 12.49576};
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 2,
      center: rome
    });

    var legend = document.getElementById('legend');
    
      for (var key in iconImages) {
        var type = iconImages[key];
        var name = type.name;
        var pic = type.icon;
        var div = document.createElement('div');
        div.innerHTML = '<img src="' + pic + '"> ' + name;
        legend.appendChild(div);
      }

      map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(legend);
}

function filterCities() {

        let monthChosen = $('#pick-month').val();
        $('#month-title').text(monthChosen);
        $.get('/lat-long.json', {month: monthChosen}, function (results){
            let latLongs = results.lat_longs;
            let region = $('#select-region').val();
            deleteMarkers();    
            makeMarkers(latLongs, monthChosen);
            changeCenter(region);

    });
    
}

function makeMarkers(latLongs, monthChosen){

            let city, image;  

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
                else if ((city.tempHigh < 80) && (city.tempHigh >= 70)) {
                    image = 'http://maps.google.com/mapfiles/ms/micons/pink.png';
                }
                else {
                    image = 'http://maps.google.com/mapfiles/ms/micons/red.png';
                }

                let content = `City: ${city.cityName} <br>
                               Summary: ${city.wSummary} <br>
                High Temperature: ${city.tempHigh} F <br>
                Low Temperature: ${city.tempLow} F <br>
                <button class="save-button" data-high="${city.tempHigh}" 
                              data-month="${monthChosen}" data-low="${city.tempLow}"
                              data-save="${city.cityId}" data-summary="${city.wSummary}"
                              data-name="${city.cityName}" data-weather="${city.weatherId}"
                              data-lat="${city.lat}" data-lng="${city.lng}">
                              Save to sidebar</button>`;
                
                let marker = new google.maps.Marker({
                    position: new google.maps.LatLng((city.lat), (city.lng)),
                    map: map,
                    title: (city.cityName),
                    icon: image
                });
                console.log(city.weatherId);
                allMarkers.push(marker);
                addInfoWindow(content, marker)
              
    }           
}

$(document).on('click', '.save-button', function (evt) {
        let cityId = $(this).data('save');
        let tempHigh = $(this).data('high');
        let tempLow = $(this).data('low');
        let summary = $(this).data('summary');
        let monthChosen = $(this).data('month');
        let weatherId = $(this).data('weather');
        let cityName = $(this).data('name');
        let cityLat = $(this).data('lat');
        let cityLong = $(this).data('lng');
        let formInputs = {
            'weatherId': weatherId,
        };
        $.post('/save-searches', formInputs, function (results){
            alert(results.message);
            let newRow = $("<tr>");
            $("<td />").html(`<input type="checkbox" class="check" id="${cityName}" data-lat="${cityLat}" data-lng="${cityLong}" value="${cityName}" />`).appendTo(newRow);
            // newRow.append($("<td>" + "<input type="checkbox" id="cityName" />" + "</td>"));
            newRow.append($("<td>" + monthChosen + "</td>"));
            newRow.append($("<td>" + cityName + "</td>"));
            newRow.append($("<td>" + tempHigh + "</td>"));
            newRow.append($("<td>" + tempLow + "</td>"));
            newRow.append($("<td>" + summary + "</td>"));

            $("#saved-cities-table").append(newRow);
            $("#saved-cities").show();

        });
    });


$(document).on('click', '#path-planner', function (evt) {

    let checkedValue = [];
    $('.check:checked').each(function(){
        let name = $(this).val();
        let lat = $(this).data('lat');
        let lng = $(this).data('lng');
        let city_info = {'name': name, 'lat': lat, 'lng': lng};
        checkedValue.push(city_info)
        debugger;
        });

    // add home logic here
    let formInputs = {'citiesChosen': checkedValue,
                      'home': homeValue};

   $.post('/calc-city-order', formInputs, function (results) {
        let orderToDisplay = results;
        console.log(orderToDisplay);

   });
});



function addInfoWindow(text, marker){
  var infoWindow = new google.maps.InfoWindow({
          content: text
      });

  google.maps.event.addListener(marker,'click', (function(marker,text,infoWindow){ 
    return function() {
        if (prevInfoWindow) {
            prevInfoWindow.close();
        }
      infoWindow.setContent(text);
      infoWindow.open(map,marker);
      prevInfoWindow = infoWindow;
  };

  })(marker,text,infoWindow)); 
}

function changeCenter(region) {

    if (region == 'africa') {
        map.setCenter({lat: 12.1348, lng: 15.0557});
    }
    else if (region == 'asia') {
        map.setCenter({lat: 16.85, lng: 96.183333});
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
    map.setZoom(4);

}

$('#month-pick').on('submit', function (evt){
    evt.preventDefault();
    filterCities();
});

    
function deleteMarkers() {
    for (var i = 0; i < allMarkers.length; i++) {
      allMarkers[i].setMap(null);
    }
}

 
