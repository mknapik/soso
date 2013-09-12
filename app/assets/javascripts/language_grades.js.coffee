# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.LanguageGrade = {}

window.LanguageGrade.initRowCheck = (id)->
  $(id + ' > tbody > tr').click(->
    if event.target.type is not 'checkbox' or $(event.target).is('.onoffswitch-inner,.onoffswitch-label,.onoffswitch-switch')
      $('input:checkbox', $(this)).trigger 'click'
  )

window.LanguageGrade.initFormSubmit = (id)->
  $(id + ' input:checkbox:not([disabled])').click ->
    checkbox = @
    preloader = $(@).parents('tr').find('.preloader')
    $(preloader).show()
    $(checkbox).attr('disabled', true)

    form = $(id).parent('form')
    obj = form.serializeArray();
    obj = obj.slice(0, 3)

    data = {'user[language_ids][]': []}
    for o in obj
      data[o.name] = o.value
    $(id + " input:checked").each ->
      data['user[language_ids][]'].push($(this).val())

    jQuery.ajax
      url: form.prop('action'),
      method: 'PUT',
      data: data
    .done (response)->
        console.log response
    .complete ->
        $(checkbox).prop('disabled', false)
        $(preloader).hide()

