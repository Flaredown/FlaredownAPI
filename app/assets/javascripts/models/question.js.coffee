App.Question = DS.Model.extend
  input_options: hasMany("question_option")
  
  catalog:  attr("string")
  name:     attr("string")
  kind:     attr("string")
  section:  attr("number")
  group:    attr("string")

# App.QuestionSerializer = DS.RESTSerializer.extend
#   extractSingle: (store, type, payload, id, requestType) ->
#     modified_payload = $().extend payload, {options: payload.input_options}
#     @._super(store, type, modified_payload , id, requestType)