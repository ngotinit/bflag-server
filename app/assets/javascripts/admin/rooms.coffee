# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#rooms-datatable').dataTable
    processing: true
    serverSide: true
    scrollX: true
    stateSave: true
    ajax:
      url: $('#rooms-datatable').data('source')
      type: 'POST'
    lengthMenu: [[5, 10, 15, 25], [5, 10, 15, 25]]
    pagingType: 'full_numbers'
    columns: [
      {data: 'id'}
      {data: 'name'}
      {data: 'show'}
      {data: 'edit'}
      {data: 'delete'}
    ]
