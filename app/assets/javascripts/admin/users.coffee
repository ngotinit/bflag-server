# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#users-datatable').dataTable
    processing: true
    serverSide: true
    scrollX: true
    ajax: $('#users-datatable').data('source')
    lengthMenu: [[5, 10, 15, 25], [5, 10, 15, 25]]
    pagingType: 'full_numbers'
    columns: [
      {data: 'id'}
      {data: 'username'}
      {data: 'email'}
      {data: 'first_name'}
      {data: 'last_name'}
      {data: 'show'}
      {data: 'edit'}
      {data: 'delete'}
    ]
