# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.LanguageGrade = {}

window.LanguageGrade.initRowCheck = (id)->
  $(id + ' > tbody > tr').click(->
    if event.target.type != 'checkbox' and !$(event.target).is('.onoffswitch-inner,.onoffswitch-label,.onoffswitch-switch')
      $('input:checkbox', $(this)).trigger 'click'
  )

window.LanguageGrade.initFormSubmit = (id)->
  $(id + ' input:checkbox').click(->
    console.log this
    console.log $(id).parent('form').serialize()
  )