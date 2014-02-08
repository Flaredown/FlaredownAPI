App.EntriesChartView = Em.View.extend
  classNames: "entries-chart"
  templateName: "entries/chart"
  
  init: ->
    @set "data", Em.A()
    @set "linksData", Em.A()
    @set "medicationsData", Em.A()
    @set "medicationsHistory", Em.A()
    @_super()

  addMedication: (coord, xScale, yScale, target) ->
    @get("medicationsData").push App.ChartMedication.create({med_id: coord.med_id, x: xScale(coord.x), label: coord.label, date: coord.x,  controller: @, target: target})
    
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

  medications: Em.computed.map "medicationsData", (medication) -> 
    medication.get("d3Format")
    
  medLines: Em.computed ->
    that = @
    @get("medicationsHistory").map (med_id) ->     
      that.get("medicationsData").filterBy("med_id", med_id).map (medication) ->
        medication.get("d3Format")
  .property("medicationsData")
  
  nodes: Em.computed.mapBy "data", "d3Format"
  
  fillCoordinates: Em.computed ->
    anchors = @get("anchors")
    anchors.unshiftObject(Em.Object.create({x: @get("anchors.firstObject.x"), y: 10000}))
    anchors.pushObject(Em.Object.create({x: @get("anchors.lastObject.x"), y: 10000}))
    anchors
  .property("data")
  
  didInsertElement: Em.observer -> 
    @setupChart()
    @renderEntries()
    @renderMedications()
  
  setupChart: ->
    that = @
    coordinates = @get("controller.user.cdai_score_coordinates")

    @set "container", $(".chart-container")
    @set "margin", {top: 35, right: 0, bottom: 35, left: 0}
    @set "width", @get("container").width() - @get("margin").left - @get("margin").right
    @set "height", @get("container").height() - @get("margin").top - @get("margin").bottom
    
    @set "y", d3.scale.linear()
      .domain([d3.min(coordinates, (d) -> d.y), d3.max(coordinates, (d) -> d.y)])
      .range [@get("height"),0]
    @set "x", d3.scale.linear()
      .domain([d3.min(coordinates, (d) -> d.x), d3.max(coordinates, (d) -> d.x)])
      .range [0, @get("width")]
      
    coordinates.forEach (coord) ->
      that.addCoordinate coord, that.get("x"), that.get("y"), that.get("controller.target") unless coord is null
      
    @set "force", d3.layout.force()
      .charge( (d) -> d.charge)
      .gravity(0)
      .linkDistance(1)
      .linkStrength(0.5)
      .size([@get("width"), @get("height")])

    @set "svg", d3.select(".chart-container").append("svg")
      .attr("id", "chart")
      .attr("width", "100%")
      .attr("height", "100%")
      .attr("viewBox","0 0 #{@get("width") + @get("margin").left + @get("margin").right} #{@get("height") + @get("margin").top + @get("margin").bottom}" )
      .append("g")
        .attr("transform", "translate(" + @get("margin").left + "," + @get("margin").top + ")")
    
    # @get("svg").selectAll("line.horizontalGrid").data(@get("y").ticks(6)).enter()
    #   .append("line")
    #     .attr
    #       "class" : "horizontalGrid"
    #       "x1" : 0
    #       "x2" : @get("width")
    #       "y1" : (d) -> that.get("y")(d)
    #       "y2" : (d) -> that.get("y")(d)
    #       "fill" : "none"
    #       "shape-rendering" : "crispEdges"
    #       "stroke" : "black"
    #       "stroke-width" : "1px"
          
    # @get("svg").selectAll("line.verticalGrid").data(@get("x").ticks(12)).enter()
    #   .append("line")
    #     .attr
    #       "class" : "verticalGrid"
    #       "y1" : 0
    #       "y2" : @get("height")
    #       "x1" : (d) -> that.get("x")(d)
    #       "x2" : (d) -> that.get("x")(d)
    #       "fill" : "none"
    #       "shape-rendering" : "crispEdges"
    #       "stroke" : "black"
    #       "stroke-width" : "1px"
  
    # MEDS
    medications = @get("controller.user.medication_coordinates")
    
    @set "medicationsHistory", Em.A(@get("controller.user.medications"))
        
    @set "meds-container", $(".meds-chart-container")
    @set "meds-margin", {top: 20, right: 0, bottom: 10, left: 0}
    @set "meds-width", @get("meds-container").width() - @get("meds-margin").left - @get("meds-margin").right
    @set "meds-height", @get("meds-container").height() - @get("meds-margin").top - @get("meds-margin").bottom

    @set "meds-y", d3.scale.linear()
      .domain([@get("medicationsHistory").length-1,0])
      .range [@get("meds-height"),0]
    @set "meds-x", d3.scale.linear()
      .domain([d3.min(medications, (d) -> d.x), d3.max(medications, (d) -> d.x)])
      .range [0, @get("meds-width")]
      
    @set "meds-svg", d3.select(".meds-chart-container").append("svg")
      .attr("id", "meds-chart")
      .attr("width", "100%")
      .attr("height", "100%")
      .attr("viewBox","0 0 #{@get("meds-width") + @get("meds-margin").left + @get("meds-margin").right} #{@get("meds-height") + @get("meds-margin").top + @get("meds-margin").bottom}" )
      .append("g")
        .attr("transform", "translate(" + @get("meds-margin").left + "," + @get("meds-margin").top + ")")
      
    medications.forEach (coord) ->
      that.addMedication coord, that.get("meds-x"), that.get("meds-y"), that.get("controller.target") unless coord is null
          
  renderEntries: ->
    that = @
    
    startLine = d3.svg.line()
      .x( (d) -> d.x )
      .y( (d) -> that.get("height")*2 )
      
    endLine = d3.svg.line()
      .x( (d) -> d.x )
      .y( (d) -> d.y )
    
    @get("svg").append("path")
      .datum(@get("anchors"))
      .attr("class", "line")
      .attr("d", startLine)
      .transition()
        .duration(1000)
        .attr("d", endLine)
      
    # @get("svg").append("path")
    #   .datum(@get("fillCoordinates"))
    #   .attr("class", "chart-fill")
    #   .attr("d", startLine)
    #   .transition()
    #     .duration(1000)
    #     .attr("d", endLine)
        
    # @get("links")
    @get("force")
      .nodes(@get("scores"))
      # .links(chartData.get("links"))
      .links([])
      .start()
            
    scoreCircle = @get("svg").selectAll("g.score-group").data(@get("scores")).enter()
      .append("circle")
        .attr
          class: "score"
          cx: (d) -> d.x
          cy: (d) -> d.y
          r: 2
        .call(@get("force").drag)
    
    
    scoreText = @get("svg").selectAll("g.score-group").data(@get("scores")).enter()
      .append("text")
        .attr
           class: "score-text"
           dx: (d) -> d.x
           dy: (d) -> d.origin.y + 8
           opacity: 0
        .style("text-anchor", "middle")
        .attr("font-family", "Arial")
        .attr("font-size", "10px")
        .text( (d) -> d.scoreText)

      
    # rect_width = width / scoreCircle[0].length
    # @get("svg").selectAll("g.score-group rect.barhitbox").data(chartData.get("anchors")).enter()
    #   .append("rect")
    #     .attr
    #       class: "barhitbox"
    #       width: rect_width
    #       height: height*2
    #       x: (d) -> d.x - (rect_width / 2)
    #       y: (d) -> 0
    #       fill: "transparent"
    #     .on("mouseenter", (d,i) -> d3.select(scoreCircle[0][d.score_index]).transition().attr("r", 20) )
    #     .on("mouseleave", (d,i) -> d3.select(scoreCircle[0][d.score_index]).transition().attr("r", 10) )
          
    @get("svg").selectAll("g.score-group circle.hitbox").data(@get("anchors")).enter()
      .append("circle")
        .attr
          class: "hitbox"
          r: (d) -> (that.get("width") / scoreCircle[0].length) / 2
          cx: (d) -> d.x
          cy: (d) -> d.y
          fill: "transparent"
        .on("mouseenter", (d,i) ->  
        
          d3.select(scoreCircle[0][d.score_index]).transition()
            .duration(200)
            .attr("r", 30)
            
          d3.select(scoreText[0][d.score_index]).transition()
            .duration(200)
            .attr("opacity", 1)
            .style("font-size", "20px")
            
        )
        .on("mouseleave", (d,i) ->  
        
          d3.select(scoreCircle[0][d.score_index]).transition()
            .duration(300)
            .attr("r", 8)
            
          d3.select(scoreText[0][d.score_index]).transition()
            .duration(300)
            .attr("opacity", 0)
            .style("font-size", "10px")
        )
        .on("click", (d,i) -> d.model.goTo())

    circles = d3.selectAll("circle")
    links = @get("svg").selectAll(".link").data(@get("links")).enter()
      .append("line")
        .attr("class", "link")
    
    @get("svg").selectAll("circle.score")
      .attr(opacity: 0)
      
      
    scoreCircle
      .transition()
        .each("start", (d,i) -> d.fixed = false)
        .duration(500)
        .delay((d,i) -> i*60)
        .attr
          opacity: 100
          r: 8
        
      
    @get("force").on "tick", (e) ->
      k = .2 * e.alpha
      
      scoreCircle.each (o, i) ->
        o.y += (o.origin.y - o.y) * k
        o.x += (o.origin.x - o.x) * k
      
      links
        .attr("x1", (d) -> d.source.x)
        .attr("y1", (d) -> d.source.y)
        .attr("x2", (d) -> d.target.x)
        .attr("y2", (d) -> d.target.y)
        
      scoreCircle
        .attr("cx", (d) -> d.x)
        .attr("cy", (d) -> d.y)
          
  renderMedications: ->
    that = @
    
    @get("medLines").forEach (medLine) ->
      
      line = d3.svg.line().x( (d) -> d.x ).y( (d) -> d.y )
    
      that.get("meds-svg").append("path")
        .datum(medLine)
        .attr("class", "med-line")
        .attr("d", line)
    
    medication = @get("meds-svg").selectAll("g.medication-group").data(@get("medications")).enter()
      .append("g")
        .attr(class: "medication-group")
        .on("mouseenter", (d,i) ->
          d3.select(this).select("circle").transition()
            .duration(100)
            .attr
              r: 10
          d3.select(this).select("text").transition()
            .duration(100)
            .attr
              "opacity": 1
              "dy": (d) -> d.y - 20
            .style("font-size", "15px")
        )
        .on("mouseleave", (d,i) ->
          d3.select(this).select("circle").transition()
            .duration(100)
            .attr
              r: 8
          d3.select(this).select("text").transition()
            .duration(10)
            .attr
              "opacity": 0
              "dy": (d) -> d.y
            
            .style("font-size", "10px")
        )
          
    medication.append("text")
      .attr
         class: "med-text"
         dx: (d) -> d.x
         dy: (d) -> d.y
         opacity: 0
      .style("text-anchor", "middle")
      .attr("font-family", "Arial")
      .attr("font-size", "10px")
      .text( (d) -> d.text)
      
    medication.append("circle")
      .attr
        class: (d) -> "medication med-level-#{d.medClass+1}"
        cx: (d) -> d.x
        cy: (d) -> d.y
        r: 8
