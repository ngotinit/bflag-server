# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#users-datatable').dataTable
    processing: true
    serverSide: true
    ajax: $('#users-datatable').data('source')
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
