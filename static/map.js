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
    // center map on rome and render map
    let rome = {lat: 41.90311, lng: 12.49576};
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 2,
      center: rome
    });
    // add legend with color coded markers
    var legend = document.getElementById('legend');
    
      for (var key in iconImages) {
        var type = iconImages[key];
        var name = type.name;
        var pic = type.icon;
        var div = document.createElement('div');
        div.innerHTML = '<img src="' + pic + '"> ' + name;
        legend.appendChild(div);
      }
      // push legend to bottom left of map
      map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(legend);
}

function filterCities() {
    // grab value from month drop down make markers using the weather data
    // from that month, recenter the map according to region
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
    // set each marker color to a corresponding temperature
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
        // create the info windows and set data attributes for save to sidebar use
        let content =  `City: ${city.cityName} <br>
                        Summary: ${city.wSummary} <br>
                        High Temperature: ${city.tempHigh} F <br>
                        Low Temperature: ${city.tempLow} F <br>
                    <button class="save-button " id="info-btn" 
                    data-high="${city.tempHigh}" 
                    data-month="${monthChosen}" data-low="${city.tempLow}"
                    data-save="${city.cityId}" data-summary="${city.wSummary}"
                    data-name="${city.cityName}" data-weather="${city.weatherId}"
                    data-lat="${city.lat}" data-lng="${city.lng}">
                    Save City</button>`;
        
        let marker = new google.maps.Marker({
            position: new google.maps.LatLng((city.lat), (city.lng)),
            map: map,
            title: (city.cityName),
            icon: image
        });

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
    // grab data from info windows and pass to save searches
    let formInputs = {'weatherId': weatherId,
                      'cityId': cityId,
                      'cityName': cityName};
    // save trips to database with post request
    $.post('/save-searches', formInputs, function (results){
             swal(results.message);
        // add new rows to saved searches table display
        if (results.message !== 'Hometown saved. You can start adding cities to your vacation now!'){
            let newRow = $("<tr>");
            $("<td />").html(`<input type="checkbox" class="check" id="${cityName}" data-del="${weatherId}" data-lat="${cityLat}" data-lng="${cityLong}" value="${cityName}" />`).appendTo(newRow);
            // newRow.append($("<td>" + "<input type="checkbox" id="cityName" />" + "</td>"));
            newRow.append($("<td>" + monthChosen + "</td>"));
            newRow.append($("<td>" + cityName + "</td>"));
            newRow.append($("<td>" + tempHigh + "</td>"));
            newRow.append($("<td>" + tempLow + "</td>"));
            newRow.append($("<td>" + summary + "</td>"));

            $("#saved-cities-table").append(newRow);
        } // only show the hometown if user has selected one and hide month 
        // until they select hometown
        else{
            $('#no-hometown').hide();
            $('#hometown-name').text(cityName);
            $('#has-hometown').show();
            $('#month-dropdown').show();
        }     
    });
});

$(document).on('click', '#delete-cities', function (evt) {
    let checkedValues = [];
    // get values from checkboxes and remove from display table
    $('.check:checked').each(function(){
        let name = $(this).val();
        let weatherId = $(this).data('del');
        let city_info = {'name': name, 'weatherId': weatherId};
        checkedValues.push(city_info)

        if ($(this).is(":checked")){
            $(this).parents("tr").remove();
        }
         
     });
    // send checkbox values back to db to delete from trip table
    let formInputs = {'citiesChosen': checkedValues};
    let formJSON = JSON.stringify(formInputs);

    $.post('/delete-cities', {'json': formJSON}, function (results) {
        // deleted from database via server and return results
        swal(results.message);
    });

});

$(document).on('click', '#path-planner', function (evt) {

    let checkedValues = [];
    // get values from check boxes to send to route planner functions
    $('.check:checked').each(function() {

        let name = $(this).val();
        let lat = $(this).data('lat');
        let lng = $(this).data('lng');
        let city_info = {'name': name, 'lat': lat, 'lng': lng};
        checkedValues.push(city_info);
        $(this).prop('checked', false);
         
    });

    let formInputs = {'citiesChosen': checkedValues};              
    let formJSON = JSON.stringify(formInputs);
    // send cities to calculation for distance, graph, ideal path
   $.post('/calc-city-order', {'json': formJSON}, function (results) {
        let orderToDisplay = results;
        $('#path').text('');
        // display the route to user
        for (let city in orderToDisplay){
            $('#path').append(orderToDisplay[city] + "&nbsp; &nbsp;");
        }
   });

});


function addInfoWindow(text, marker){
  var infoWindow = new google.maps.InfoWindow({
          content: text
      });
  // set up markers so they automatically close when another one opens
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
    // recenter map when new region selected from dropdown
    if (region == 'africa') {
        map.setCenter({lat: -15.40884, lng: 28.2824});
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
        map.setCenter({lat: 45.759399, lng: 4.82897});
    }
    map.setZoom(4);

}
// intercept form from month drop down and call filterCities for map display
$('#month-pick').on('submit', function (evt){
    evt.preventDefault();
    filterCities();
});

// clear all markers
function deleteMarkers() {
    for (var i = 0; i < allMarkers.length; i++) {
      allMarkers[i].setMap(null);
    }
}

 
