App.Question = DS.Model.extend
  input_options: hasMany("question_option")
  
  catalog:  attr("string")
  name:     attr("string")
  kind:     attr("string")
  section:  attr("number")
  group:    attr("string")
  
  inputPartial: Em.computed ->
    "questioner/#{@get("kind")}_input"
  .property("kind")

App.QuestionSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    input_options: {embedded: "always"}