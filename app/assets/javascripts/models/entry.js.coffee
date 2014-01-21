App.Entry = DS.Model.extend
  user:       belongsTo("user")
  
  scores:     hasMany("score")
  questions:  hasMany("question")
  responses:  hasMany("response")
  catalogs:   attr()
  date:       attr("string")
  
  # questions:  attr("object")
  # responses:  attr("object")
  # treatments: attr("object")
  # catalogs:   attr("object")
  
  entryDate: Em.computed -> 
    moment(@get("date")).format("MMM-DD-YYYY")
  .property("date")
  
  entryDateParam: Em.computed -> 
    return "today" if moment().format("MMM-DD-YYYY") is @get("entryDate")
    @get("entryDate")
  .property("entryDate")
  
  # jsDate: Em.computed ->
  #   Date.parse "#{@get("date")}"
  # .property("date")
  
  responsesData: Em.computed ->
    normalized = Em.A([])
    @get("responses").forEach (response) ->
      switch response.get("question.kind")
        when "number"
          if response.get("value")
            normalized.push(response)
            response.set("value", parseInt(response.get("value")) )
        when "select"
          if response.get("value")
            normalized.push(response)
            response.set("value", parseInt(response.get("value")) )
        when "checkbox"
          response.set("value", false) unless response.get("value")
          normalized.push(response)
            
    normalized.map (response) -> {name: response.get("name"), value: response.get("value")}
  .property("responses.@each.value")
  
App.EntrySerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    responses: {embedded: "always"}
    questions: {embedded: "always"}