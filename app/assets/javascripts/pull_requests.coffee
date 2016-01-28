setupFilterButton = ->
  $('#filter').on 'click', (event) ->
    event.preventDefault()
    url = '/pull-requests/'
    $(':checked').each (index, element) =>
      url += $(element).attr('id') + ','
    $('#filter').href = url
    window.location.href = url

setupFilterButton()