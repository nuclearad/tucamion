// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.inputmask
//= require jquery.inputmask.extensions
//= require jquery.inputmask.numeric.extensions
//= require jquery.inputmask.date.extensions
//= require jquery_ujs
//= require turbolinks


var ready;
ready = function() {
    console.log('desde el application.js');
    $('#customer_telefono').inputmask('(9999)-9999999');
    $('#truck_customer_attributes_telefono').inputmask('(9999)-9999999');
    $('#extra_phone').inputmask('(9999)-9999999');
    $('#service_phone').inputmask('(9999)-9999999');
    $('#message_telefono').inputmask('(9999)-9999999');

    
};

$(document).ready(ready);
$(document).on('page:load', ready);

