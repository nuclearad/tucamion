# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

remove_mask = ->

  return


$(document).on "page:change", ->
  console.log 'page:change call'
  $('#customer_telefono').inputmask '(9999)-9999999'

  return