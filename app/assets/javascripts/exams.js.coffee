# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Exams = {}
window.Exams.selector = ''
window.Exams.configuration = {}
window.Exams.events = []

window.Exams.colors =
  active:
    min: '#3A87AD'
    open: '#16A765'
    full: '#F83A22'
  inactive:
    min: '#9FC6E7'
    open: '#DCF1DB'
    full: '#D06B64'

window.Exams.init = (selector, startDate, min = 8, max = 20) ->
  window.Exams.selector = selector
  window.Exams.configuration = {startDate: startDate}
  window.Exams.events = []

window.Exams.addEvent = (event, user_status) ->
  startDate = new Date(Number(event.start)*1000)
  endDate = new Date(Number(event.end)*1000)

  full_title = [event.language_name, '-'
    if event.places.left == 0
      'full'
    else [event.places.left, 'places left'].join(' ')
  ].join(' ')
  myEvent = {
    id: event.id
    title: full_title
    start: startDate
    end: endDate
    allDay: false
    editable: false
  }
#    color:
  console.log user_status
  console.log user_status.languages
  console.log user_status.languages[event.language_id]

  status = if event.places.left == 0 then 'full' else if event.places.occupied < event.places.min then 'min' else 'open'
  undef = user_status.languages[event.language_id] is undefined or user_status.languages[event.language_id] is null
  if (undef) or (user_status.languages[event.language_id] == event.id)
    myEvent.color = window.Exams.colors['active'][status]
    myEvent.url = ['/users', user_status.user_id, 'exams', event.id,
      if undef then 'sign_up' else 'release'
    ].join('/')
  else
    myEvent.color = window.Exams.colors['inactive'][status]
  window.Exams.events.push myEvent

window.Exams.render = () ->
  $(window.Exams.selector).fullCalendar
#    weekends: false
    slotMinutes: 30
    minTime: Math.max(9)
    maxTime: Math.min(19)
    aspectRatio: 2.2
    editable: false
    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek"

    editable: true
    events: window.Exams.events