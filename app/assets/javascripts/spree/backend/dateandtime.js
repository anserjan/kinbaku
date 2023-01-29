'use strict';

Spree.ready(function(){

    $('.datetimepicker').flatpickr({
        allowInput: true,
        enableTime: true,
        time_24hr: true,
        //dateFormat: "d-m-Y",
        dateFormat: "Y-m-d H:i",
    });

});