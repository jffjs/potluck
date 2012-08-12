# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # Add a new ingredient input
  $("#add_ingredient").click ->
    index = $("#index").val()
    next = $(".ingredient:last input").clone()
    next.attr('id', next.attr('id').replace(index-1, index))
    next.attr('name', next.attr('name').replace(index-1, index))
    $(".ingredient:last").after($('<div class="ingredient"></div>').append(next))
    $("#index").val(parseInt(index) + 1)
