App.MedicationDatum = Em.Controller.extend
  dataBinding: "controller.medicationsData"
  
  text: Em.computed ->
    if @get("dosage")
      "#{@get('label')} - #{@get('dosage')}"
    else
      @get("label")
  .property("label", "dosage")
  
  entryDate: Em.computed -> 
    moment(@get("date")*1000).format("MMM-DD-YYYY")
  .property("x")
  
  level: Em.computed ->
    that = @
    @get("data").filter (datum) ->
      datum.date is that.get("date")
    .sortBy("medClass").indexOf(this)
  .property("date", "med_id")
  
  medClass: Em.computed ->
    @get("controller.medicationsHistory").indexOf(@get("med_id"))
  .property("med_id")
  
  y: Em.computed ->
    @get("level")
  .property("level")
  
  index: Em.computed ->
    @get("data").indexOf(@)
  .property("data")
    
  # origin: Em.computed ->
  #   {x: @get("x"), y:@get("y")}
  # .property()
  
  objectFormat: Em.computed ->
    Em.Object.create @getProperties("x", "y", "level", "medClass", "text")
  .property("")
  
  d3Format: Em.computed ->
    @get("objectFormat").setProperties index: @get("data").indexOf(@), model: @
  .property("kind")
  
  goTo: -> @transitionToRoute("entries.entry", @get("entryDate"), 1)