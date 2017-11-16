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
