# Initial data structure.
lessonFile = {
  title: null,
  summary: null,
  image_url: null,
  author_github_username: null,
  events: [
    {
      location: null,
      date: null,
      length_in_hours: null,
      teacher_github_username: null
    }
  ]
}

# Is this field an event field?
isEventField = (fieldName) ->
  switch fieldName
    when "location", "date", "length_in_hours", "teacher_github_username" then true
    else false

# Update lessonFile fieldName with fieldValue.
updateLessonFile = (fieldName, fieldValue) ->
  if isEventField(fieldName)
    lessonFile["events"][0][fieldName] = fieldValue
  else
    lessonFile[fieldName] = fieldValue

# Print lesson to screen.
printLessonFile = ->
  prettyLessonFile = JSON.stringify(lessonFile, null, "  ")
  $("#result").val(prettyLessonFile)

# Listen for keyup on input fields and update lesson and print to screen.
$(document).on "keyup", "#json-builder .input-field", ->
  $input = $(this)
  fieldName = $input.prop("name")
  fieldValue = $input.val()
  updateLessonFile(fieldName, fieldValue)
  printLessonFile()

# Print lesson to screen on load.
printLessonFile() if $("#result").length > 0
