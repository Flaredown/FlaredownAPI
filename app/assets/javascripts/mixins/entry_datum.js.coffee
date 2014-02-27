App.EntryDatum = Em.Controller.extend
  # dataBinding: "controller.scoreData"
  
  scoreText: Em.computed(->
    switch @get("type")
      when "normal"
        if @get("origin.y") is -1
          return "!"
        else
          return @get("y")
      when "missing" then "?"
  )
  text: Em.computed(-> "#{moment(@get('date')).format('MM/DD')} - #{@get('y')}" ).property("x", "y")
  classes: Em.computed(->
    switch @get("type")
      when "normal"
        if @get("origin.y") is -1
          return "incomplete"
        else
          return ""
      when "missing" then return "missing"
      
  ).property("type")
  
  entryDate: Em.computed -> 
    moment(@get("date")*1000).format("MMM-DD-YYYY")
  .property("x")
  
  # objectFormat: Em.computed ->
  #   Em.Object.create @getProperties("id", "text", "index", "origin", "scoreText")
  # .property()
  
  d3Format: Em.computed ->
    Em.Object.create(@getProperties("id", "text", "index", "origin", "scoreText", "classes")).setProperties fixed: false, startx: @get("x"), model: @
  .property()
  
  goTo: -> @get("controller").transitionToRoute("entries.entry", @get("entryDate"), 1)