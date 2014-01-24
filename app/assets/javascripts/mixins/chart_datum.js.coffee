App.ChartDatum = Em.Controller.extend
  text: Em.computed ->
    "#{moment(@get('date')).format('MM/DD')} - #{@get('y')}"
  .property("x", "y")
  
  entryDate: Em.computed -> 
    moment(@get("date")).format("MMM-DD-YYYY")
  .property("x")
  
  index: Em.computed ->
    @get("controller.data").indexOf(@)
  .property("controller.data")
  
  scoreIndex: Em.computed ->
    score = @get("controller.scores").findBy("index", @get("score.index"))
    @get("controller.scores").indexOf(score)
  .property("controller.scores", "score")
  
  origin: Em.computed ->
    {x: @get("x"), y:@get("y")}
  .property()
  
  objectFormat: Em.computed ->
    Em.Object.create @getProperties("x", "y", "text", "index", "origin", "scoreText")
  .property("")
  
  d3Format: Em.computed ->
    switch @get("kind")
      when "anchor"
        @get("objectFormat").setProperties index: @get("controller.data").indexOf(@), fixed: true, model: @, charge: -10, score_index: @get("scoreIndex")
      when "score"
        @get("objectFormat").setProperties index: @get("controller.data").indexOf(@), fixed: true, y: 0, model: @, charge: -10
  .property("kind")
  
  goTo: -> @transitionToRoute("entry", @get("entryDate"), 1)