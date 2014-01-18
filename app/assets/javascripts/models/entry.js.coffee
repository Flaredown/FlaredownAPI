App.Entry = DS.Model.extend
  user:       belongsTo("user")
  
  scores:     hasMany("score")
  questions:  hasMany("question")
  responses:  hasMany("response")
  catalogs:   attr()
  date:   attr("date")
  
  # questions:  attr("object")
  # responses:  attr("object")
  # treatments: attr("object")
  # catalogs:   attr("object")
  
  jsDate: Em.computed ->
    Date.parse "#{@get("date")}"
  .property("date")
  
App.EntrySerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    responses: {embedded: "always"}