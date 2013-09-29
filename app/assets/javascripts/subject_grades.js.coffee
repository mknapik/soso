window.SubjectGrades = {}
window.SubjectGrades.recalculate = ->
  grade_sum = 0.0
  ects_sum = 0.0
  $("#user_grades > tbody > tr").each (->
    grade = parseFloat($(this).data('grade'))
    ects = parseFloat($(this).data('ects'))
    grade_sum += grade * ects
    ects_sum += ects
  )
  console.log(grade_sum)

  $("#user_grades_average").html(Math.round(1000 * grade_sum / ects_sum) / 1000)
  $("#user_ects_sum").html(Math.round(ects_sum))


# Return a helper with preserved width of cells
window.SubjectGrades.fixHelper = (e, ui) ->
  ui.children().each ->
    $(this).width $(this).width()
  ui

window.SubjectGrades.init_subject_select2 = ->
  format = (item) ->
    item.name
  $('#subject_grade_subject_id').select2
    data:
      results: $('#subject_grade_subject_id').data "subjects"
      text: 'name'
    formatResult: format
    formatSelection: format
    minimumInputLength: 2
    multiple: false
    createSearchChoice: (term, data) ->
      if $(data).filter(->
        this.name.localeCompare(term, 'en', {sensitivity: 'base'}) == 0).length == 0
        id: term,
        name: term + ' (new)'

  $('#subject_grade_subject_id').on('change', (val) ->
    console.log(val)
    $('#subject_grade_subject').val(if val.val is '' then val.added.id else '')
  )

window.SubjectGrades.sortableList (selector) ->
  $(selector).sortable(
    axis: 'y'
    helper: SubjectGrades.fixHelper
    update: (data)->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  ).disableSelection
