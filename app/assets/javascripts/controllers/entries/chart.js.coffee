App.EntriesChartController = Ember.Controller.extend
  needs: ["user"]
  userBinding: "controllers.user"

  entriesData: Em.A()
  linksData: Em.A()
  medicationsData: Em.A()
  medicationsHistory: Em.A()
  
  addData: (data) ->    
    that = @
    data.forEach (catalog) ->
      catalog.scores.forEach (score) -> that.addEntry score, catalog.name
    # data.medications.forEach (score) -> that.addMedication score
    
  addMedication: (coord) ->
    @get("medicationsData").push App.MedicationDatum.create({med_id: coord.med_id, x: @get("medsX")(coord.x), label: coord.label, date: coord.x,  controller: @})
    
  addEntry: (coord, catalog) ->
    score   = App.EntryDatum.create({catalog: catalog, x: coord.x, y: coord.y, date: coord.x, scoreText: coord.y, kind: "score",  controller: @})
    anchor  = App.EntryDatum.create({catalog: catalog, x: coord.x, y: coord.y, date: coord.x, scoreText: coord.y, kind: "anchor", controller: @, score: score})
    @get("entriesData").push score
    @get("entriesData").push anchor
    @get("linksData").push {source: anchor, target: score}
    
  anchors: Em.computed ->
    @get("entriesData").filterBy("kind", "anchor").map (datum) -> datum.get("d3Format")
  .property("entriesData", "entriesData.@each.kind")
  
  scores: Em.computed ->
    @get("entriesData").filterBy("kind", "score").map (datum) -> datum.get("d3Format")
  .property("entriesData", "entriesData.@each.kind")
  
  links: Em.computed.map "linksData", (link) ->
    {source: link.source.get("index"), target: link.target.get("index")}
    
  nodes: Em.computed.mapBy "entriesData", "d3Format"

  medications: Em.computed.map "medicationsData", (medication) -> medication.get("d3Format")
    
  medLines: Em.computed ->
    that = @
    @get("medicationsHistory").map (med_id) ->     
      that.get("medicationsData").filterBy("med_id", med_id).map (medication) ->
        medication.get("d3Format")
  .property("medicationsData")
  
  fillCoordinates: Em.computed ->
    [
      Em.Object.create({x: @get("scores.firstObject.x"), y: 10000, origin: {y: -10000}})
    ].concat(@get("scores"))
    .concat(Em.Object.create({x: @get("scores.lastObject.x"), y: 10000, origin: {y: -10000}}))
  .property("scores")