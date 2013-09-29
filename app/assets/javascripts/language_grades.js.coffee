# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Extended disable function
jQuery.fn.extend
  disable: (state) ->
    return this.each ->
      $this = $(this)
      if $this.is 'input, button'
        this.disabled = state
      else
        if state then $this.addClass('disabled') else $this.removeClass('disabled')

window.LanguageGrade = {}

window.LanguageGrade.formId = ''

window.LanguageGrade.initRowCheck = ->
  $(window.LanguageGrade.formId + ' table > tbody > tr').click(->
    if event.target.type != 'checkbox' or $(event.target).is('.onoffswitch-inner,.onoffswitch-label,.onoffswitch-switch')
      $('input:checkbox', $(this)).trigger 'click'
  )

window.LanguageGrade.initDisabledLinks = ->
  $('body').on 'click', 'a.disabled', (event)->
    event.preventDefault()

window.LanguageGrade.initFormSubmit = ->
  window.LanguageGrade.allCheckboxes = $(window.LanguageGrade.formId + ' input:checkbox')
  window.LanguageGrade.checkboxes = $(window.LanguageGrade.formId + ' input:checkbox:not(.paid)')
  $(window.LanguageGrade.formId + ' input:checkbox:not([disabled])').click ->
    preloader = $(@).parents('tr').find('.preloader')
    console.log(preloader)
    $(preloader).removeClass('hidden')
    $(window.LanguageGrade.checkboxes).attr('disabled', true)
    window.LanguageGrade.suspendButtons()

    form = $(window.LanguageGrade.formId)
    obj = form.serializeArray();
    obj = obj.slice(0, 3)

    data = {'user[language_ids][]': []}
    for o in obj
      data[o.name] = o.value
    $(window.LanguageGrade.formId + " input:checked").each ->
      data['user[language_ids][]'].push($(this).val())

    jQuery.ajax
      url: form.prop('action'),
      method: 'PUT',
      data: data
    .done (response)->
        console.log response
    .complete ->
        $(window.LanguageGrade.checkboxes).prop('disabled', false)
        $(preloader).addClass('hidden')
        window.LanguageGrade.restoreButtons()
        window.LanguageGrade.refreshButtons()

window.LanguageGrade.refreshButtons = ->
  btn1 = $(window.LanguageGrade.payExamButtonId)
  btn2 = $(window.LanguageGrade.skipExamButtonId)
  if window.LanguageGrade.allCheckboxes.filter(':checked').size() > 0
    btn1.disable(false)
    btn2.disable(true)
  else
    btn1.disable(true)
    btn2.disable(false)

window.LanguageGrade.initButtons = (payExamButtonId, skipExamButtonId)->
  window.LanguageGrade.payExamButtonId = payExamButtonId
  window.LanguageGrade.skipExamButtonId = skipExamButtonId

window.LanguageGrade.buttons = {}

window.LanguageGrade.suspendButtons = ->
  $(window.LanguageGrade.formId).find('button.btn, a.btn').each ->
    window.LanguageGrade.buttons[@] = $(@).hasClass('disabled')
    $(@).disable(true)

window.LanguageGrade.restoreButtons = ->
  $(window.LanguageGrade.formId).find('button.btn, a.btn').each ->
    if not window.LanguageGrade.buttons[@]
      $(@).disable(false)


window.LanguageGrade.initConfirmButton = (confirmButtonId)->
  window.LanguageGrade.confirmButtonId = confirmButtonId

window.LanguageGrade.initConfirmFormSubmit = ->
  window.LanguageGrade.allCheckboxes = $(window.LanguageGrade.formId + ' input:checkbox')
  window.LanguageGrade.checkboxes = $(window.LanguageGrade.formId + ' input:checkbox:not(.paid)')
  $(window.LanguageGrade.formId + ' input:checkbox:not([disabled])').click ->
    window.LanguageGrade.refreshConfirmButton()

window.LanguageGrade.refreshConfirmButton = ->
  btn1 = $(window.LanguageGrade.confirmButtonId)
  console.log window.LanguageGrade.confirmButtonId
  if window.LanguageGrade.allCheckboxes.filter(':checked').size() > 0
    btn1.disable(false)
  else
    btn1.disable(true)
