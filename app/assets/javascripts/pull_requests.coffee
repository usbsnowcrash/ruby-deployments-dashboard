setupFilterButton = ->
  $('#filter').on 'click', (event) ->
    event.preventDefault()
    url = '/pull-requests/'
    $(':checked').each (index, element) =>
      url += $(element).attr('id') + ','
    $('#filter').href = url
    window.location.href = url

setupAccordion = ->
  $('.accordion > dt').on 'click', ->
    target = $(this).next()
    if !this.hasClass('accordion-active')
      this.addClass 'accordion-active'
      target.addClass('active').slideDown 'fast'
    else
      target.slideUp('fast').removeClass 'active'
      this.removeClass 'accordion-active'


(($) ->
  jQuery('.accordion > dt').on 'click', ->
    $this = $(this)
    $target = $this.next()
    if !$this.hasClass('accordion-active')
      $this.addClass 'accordion-active'
      $target.addClass('active').slideDown 'fast'
    else
      $target.slideUp('fast').removeClass 'active'
      $this.removeClass 'accordion-active'
    false
  return
) jQuery


$ ->
  setupAccordion()
  setupFilterButton()
  $('.accordion > dt').trigger( 'click' )

