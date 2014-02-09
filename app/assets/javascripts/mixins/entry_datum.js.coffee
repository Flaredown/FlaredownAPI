App.EntryDatum = Em.Controller.extend
  # dataBinding: "controller.scoreData"

  text: Em.computed(-> "#{moment(@get('date')).format('MM/DD')} - #{@get('y')}" ).property("x", "y")
  
  entryDate: Em.computed -> 
    moment(@get("date")*1000).format("MMM-DD-YYYY")
  .property("x")
  
  # objectFormat: Em.computed ->
  #   Em.Object.create @getProperties("id", "text", "index", "origin", "scoreText")
  # .property()
  
  d3Format: Em.computed ->
    Em.Object.create(@getProperties("id", "text", "index", "origin", "scoreText")).setProperties fixed: false, startx: @get("x"), model: @
  .property()
  
  goTo: -> @get("controller").transitionToRoute("entries.entry", @get("entryDate"), 1)