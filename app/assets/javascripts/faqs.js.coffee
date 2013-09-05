window.Faqs = {}

window.Faqs.initToggle = ->
  $('.question').on('click', (e)->
#    e.preventDefault()
    collapseParagraph = $(this).closest('.collapse-group').find('.collapse')
    collapseParagraph.collapse 'toggle'
  )

window.Faqs.collapseAll = ->
  $('.question').closest('.collapse-group').find('.collapse').collapse('hide')

window.Faqs.expandAll = ->
  $('.question').closest('.collapse-group').find('.collapse').collapse('show')

window.Faqs.initSort = ->
  $('#faqs_list').sortable(
    axis: 'y'
    handle: '.question-box'
    update: (data)->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  )