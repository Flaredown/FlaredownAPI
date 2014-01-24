App.ChartDataController = Em.ObjectProxy.extend
  init: ->
    @set "data", Em.A()
    @set "linksData", Em.A()
    @_super()
  
  addCoordinate: (coord, xScale, yScale, target) ->
    score   = App.ChartDatum.create({x: xScale(coord.x), y: yScale(coord.y), date: coord.x, scoreText: coord.y, kind: "score",  controller: @, target: target})
    anchor  = App.ChartDatum.create({x: xScale(coord.x), y: yScale(coord.y), date: coord.x, scoreText: coord.y, kind: "anchor", controller: @, target: target, score: score})
    @get("data").push score
    @get("data").push anchor
    @get("linksData").push {source: anchor, target: score}
    
  anchors: Em.computed ->
    @get("data").filterBy("kind", "anchor").map (datum) -> datum.get("d3Format")
  .property("data", "data.@each.kind")
  
  scores: Em.computed ->
    @get("data").filterBy("kind", "score").map (datum) -> datum.get("d3Format")
  .property("data", "data.@each.kind")
  
  links: Em.computed.map "linksData", (link) ->
    {source: link.source.get("index"), target: link.target.get("index")}
  
  nodes: Em.computed.mapBy "data", "d3Format"
  
  fillCoordinates: Em.computed ->
    anchors = @get("anchors")
    anchors.unshiftObject(Em.Object.create({x: @get("anchors.firstObject.x"), y: 10000}))
    anchors.pushObject(Em.Object.create({x: @get("anchors.lastObject.x"), y: 10000}))
    anchors
  .property("data")