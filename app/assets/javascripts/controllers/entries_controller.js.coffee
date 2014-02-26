App.EntriesController = Ember.ArrayController.extend
  needs: ["user"]
  userBinding: "controllers.user"
  sortProperties: ["unixDate"]
  sortAscending: true
  
  hasScores: Em.computed.notEmpty "catalog.scores.[]"
  
  startDateFormatted: Em.computed( -> @get("startDate").format("MMM-DD-YYYY")).property("startDate")
  endDateFormatted: Em.computed( -> @get("endDate").format("MMM-DD-YYYY")).property("startEnd")
  
  catalogName: "cdai"
  catalog: Em.computed ->
    that = @
    @get("content").find (catalog) -> catalog.name == that.get("catalogName")
  .property("content.@each")
  
  dateRange: Em.computed( ->
    console.log @get("catalog.scores")
    current = moment(@get("catalog.scores.firstObject.x")*1000)
    range   = Em.A([current.unix()])
    a_day   = moment.duration(86400*1000)
    
    if @get("hasScores")
      until range.get("lastObject") is @get("catalog.scores.lastObject.x")
        current.add a_day
        range.pushObject current.unix()
      range
    else
      Em.A()
      
  ).property("catalog.scores")
    
  # addMedication: (coord) ->
  #   @get("medicationsData").push App.MedicationDatum.create({med_id: coord.med_id, x: @get("medsX")(coord.x), label: coord.label, date: coord.x, controller: @})
  
  scoreByUnix: (unix) -> @get("catalog.scores").find (score) -> score.x == unix
  
  datum:        (coord) -> App.EntryDatum.create({id: coord.x.toString(), catalog: @get("catalogName"), x: coord.x, y: coord.y, origin: {x: coord.x, y: coord.y}, date: coord.x, scoreText: coord.y, controller: @})
  missingDatum: (coord) -> App.EntryDatum.create({id: coord.x.toString(), catalog: @get("catalogName"), x: coord.x, y: coord.y, origin: {x: coord.x, y: coord.y}, date: coord.x, scoreText: null, controller: @})
  
  scoreData: Em.computed.map("dateRange", (unix) ->
    that = @
    score = that.scoreByUnix(unix)
    if score
      that.datum(score)
    else
      that.missingDatum({x: unix, y: 0})
  )
      
  scores: Em.computed.mapBy("scoreData", "d3Format")

  # nodes: Em.computed.map "scores", (score) -> {id: score.get("x"), x: score.get("x"), y: score.get("y"), px: score.get("x"), py: score.get("y")}
  
  # links: Em.computed.map "linksData", (link) ->
  #   {source: link.source.get("index"), target: link.target.get("index")}

  medications: Em.computed.map "medicationsData", (medication) -> medication.get("d3Format")
    
  medLines: Em.computed ->
    that = @
    @get("medicationsHistory").map (med_id) ->     
      that.get("medicationsData").filterBy("med_id", med_id).map (medication) ->
        medication.get("d3Format")
  .property("medicationsData")
  
  actions:
    setDateRange: (start, end) ->
      # TODO check formatting of start/end
      
      that = @
      $.ajax(
        url: "/chart"
        method: "GET"
        data: 
          start_date: start
          end_date: end
      ).then(
        (response) ->
          # that.set "catalog.scores", response.chart[0].scores
          # response.chart.forEach (catalog) ->
          #   that.get("model").select (catalogs) -> catalogs
          #   catalog
          Ember.run.once ->
            that.set("model", response.chart)
            
          
        (response) ->
          console.log "?!?! error on getting chart"
      )