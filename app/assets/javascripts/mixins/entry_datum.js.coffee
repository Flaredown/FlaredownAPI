App.EntryDatum = Em.Controller.extend
  dataBinding: "controller.entriesData"

  text: Em.computed(-> "#{moment(@get('date')).format('MM/DD')} - #{@get('y')}" ).property("x", "y")
  
  entryDate: Em.computed -> 
    moment(@get("date")*1000).format("MMM-DD-YYYY")
  .property("x")
  
  index: Em.computed ->
    @get("controller.entriesData").filterBy("kind", "score").indexOf(@)
  .property("controller.entriesData")
  
  scoreIndex: Em.computed ->
    score = @get("controller.scores").findBy("index", @get("score.index"))
    @get("controller.scores").indexOf(score)
  .property("controller.scores", "score")
  
  origin: Em.computed ->
    {x: @get("x"), y: @get("y")}
  .property()
  
  objectFormat: Em.computed ->
    Em.Object.create @getProperties("x", "y", "text", "index", "origin", "scoreText")
  .property("")
  
  d3Format: Em.computed ->
    switch @get("kind")
      when "anchor"
        @get("objectFormat").setProperties index: @get("controller.entriesData").indexOf(@), fixed: true, model: @, charge: -10, score_index: @get("scoreIndex")
      when "score"
        @get("objectFormat").setProperties index: @get("controller.entriesData").indexOf(@), fixed: true, y: 0, model: @, charge: -10
  .property("kind")
  
  goTo: -> @get("controller").transitionToRoute("entries.entry", @get("entryDate"), 1)