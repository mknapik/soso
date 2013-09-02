window.SubjectGrades = {}
window.SubjectGrades.recalculate = ->
  grade_sum = 0.0
  ects_sum = 0.0
  count = 0.0
  $("#user_grades > tbody > tr").each (->
    grade_sum += parseFloat($(this).data('grade'))
    ects_sum += parseFloat($(this).data('ects'))
    count++
  )
  console.log(grade_sum)

  $("#user_grades_average").html(grade_sum / count)
  $("#user_ects_sum").html(ects_sum)