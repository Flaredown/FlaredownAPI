App.EntriesView = Em.View.extend()
  # click: -> @get("controller").send("updates")
  
  # watchEntries: Em.observer( ->
  #   console.log "rendering entries chart"
  #   @renderEntries()
  # ).observes("controller.scores.length").on("didInsertElement")
  #     
  # click: -> 
  #   @get("controller").send("updates")
  # 
  # setupEntries: ->
  #   that = @
  #   controller = @get("controller")
  # 
  #   @set "container", $(".chart-container")
  #   @set "margin", {top: 50, right: 50, bottom: 50, left: 50}
  #   @set "width", @get("container").width() - @get("margin").left - @get("margin").right
  #   @set "height", @get("container").height() - @get("margin").top - @get("margin").bottom
  # 
  #   @set("entriesX", d3.scale.linear()
  #     .domain([d3.min(controller.get("scores"), (d) -> d.x), d3.max(controller.get("scores") , (d) -> d.x)])
  #     .range [0, @get("width")])
  #   
  #   @set("entriesY", d3.scale.linear()
  #     .domain([d3.min(controller.get("scores") , (d) -> d.origin.y), d3.max(controller.get("scores") , (d) -> d.origin.y)])
  #     .range [@get("height"),0])
  # 
  #   @set("force", d3.layout.force()
  #     .charge( (d) -> d.charge)
  #     .gravity(0)
  #     .linkDistance(1)
  #     .linkStrength(0.5)
  #     .size([@get("width"), @get("height")]))
  # 
  #   @set("entries-svg", d3.select(".chart-container").append("svg")
  #     .attr("id", "chart")
  #     .attr("width", "100%")
  #     .attr("height", "100%")
  #     .attr("viewBox","0 0 #{@get("width") + @get("margin").left + @get("margin").right} #{@get("height") + @get("margin").top + @get("margin").bottom}" )
  #     .append("g")
  #       .attr("transform", "translate(" + @get("margin").left + "," + @get("margin").top + ")"))
  #   
  #   @get("entries-svg").selectAll("line.horizontalGrid").data(@get("entriesY").ticks(6)).enter()
  #     .append("line")
  #       .attr
  #         "class" : "horizontalGrid"
  #         "x1" : 0
  #         "x2" : @get("width")
  #         "y1" : (d) -> that.get("entriesY")(d)
  #         "y2" : (d) -> that.get("entriesY")(d)
  #         "fill" : "none"
  #         "shape-rendering" : "crispEdges"
  #         "stroke" : "black"
  #         "stroke-width" : "1px"
  #         
  #   @get("entries-svg").selectAll("line.verticalGrid").data(@get("entriesX").ticks(controller.get("scores.length"))).enter()
  #     .append("line")
  #       .attr
  #         "class" : "verticalGrid"
  #         "y1" : 0
  #         "y2" : @get("height")
  #         "x1" : (d) -> that.get("entriesX")(d)
  #         "x2" : (d) -> that.get("entriesX")(d)
  #         "fill" : "none"
  #         "shape-rendering" : "crispEdges"
  #         "stroke" : "black"
  #         "stroke-width" : "1px"
  #         
  #   @set("startLine", d3.svg.line()
  #     .x( (d) -> that.get("entriesX")(d.x) )
  #     .y( (d) -> that.get("height")*2 )
  #   )
  #     
  #   @set("endLine", d3.svg.line()
  #     .x( (d) -> that.get("entriesX")(d.x) )
  #     .y( (d) -> that.get("entriesY")(d.origin.y) )
  #   )
  # 
  # setupMeds: ->
  #   that = @
  #   controller = @get("controller")
  #   medications = @get("controller.user.medication_coordinates")
  #   
  #   controller.set "medicationsHistory", Em.A(@get("controller.user.medications"))
  #       
  #   @set "meds-container", $(".meds-chart-container")
  #   @set "meds-margin", {top: 50, right: 50, bottom: 10, left: 50}
  #   @set "meds-width", @get("meds-container").width() - @get("meds-margin").left - @get("meds-margin").right
  #   @set "meds-height", @get("meds-container").height() - @get("meds-margin").top - @get("meds-margin").bottom
  # 
  #   @set("medsX", d3.scale.linear()
  #     .domain([d3.min(medications, (d) -> d.x), d3.max(medications, (d) -> d.x)])
  #     .range [0, @get("meds-width")])
  #     
  #   @set("medsY", d3.scale.linear()
  #     .domain([controller.get("medicationsHistory").length-1,0])
  #     .range [@get("meds-height"),0])
  #     
  #   @set("meds-svg", d3.select(".meds-chart-container").append("svg")
  #     .attr("id", "meds-chart")
  #     .attr("width", "100%")
  #     .attr("height", "100%")
  #     .attr("viewBox","0 0 #{@get("meds-width") + @get("meds-margin").left + @get("meds-margin").right} #{@get("meds-height") + @get("meds-margin").top + @get("meds-margin").bottom}" )
  #     .append("g")
  #       .attr("transform", "translate(" + @get("meds-margin").left + "," + @get("meds-margin").top + ")"))
  #         
  # renderEntries: ->
  #   @setupEntries() unless @get("entries-svg")
  #   controller = @get("controller")
  #   that = @
  #   
  #   @get("entries-svg").append("path")
  #     .datum(controller.get("scores"))
  #     .attr("class", "line")
  #     .attr("d", startLine)
  #     .transition()
  #       .duration(1000)
  #       .attr("d", endLine)
  #     
  #   @get("entries-svg").append("path")
  #     .datum(controller.get("fillCoordinates"))
  #     .attr("class", "chart-fill")
  #     .attr("d", startLine)
  #     .transition()
  #       .duration(1000)
  #       .attr("d", endLine)
  #       
  #   @get("force")
  #     .nodes(controller.get("scores"))
  #     # .links(chartData.get("links"))
  #     .links([])
  #     .start()
  #           
  #   scoreCircle = @get("entries-svg").selectAll("g.score-group").data(controller.get("scores")).enter()
  #     .append("circle")
  #       .attr
  #         class: "score"
  #         cx: (d) -> that.get("entriesX")(d.x)
  #         cy: (d) -> that.get("entriesY")(d.y)
  #         r: 3
  #       .call(@get("force").drag)
  #   
  #   scoreText = @get("entries-svg").selectAll("g.score-group").data(controller.get("scores")).enter()
  #     .append("text")
  #       .attr
  #          class: "score-text"
  #          dx: (d) -> that.get("entriesX")(d.origin.x)
  #          dy: (d) -> that.get("entriesY")(d.origin.y) + 8
  #          opacity: 0
  #       .style("text-anchor", "middle")
  #       .attr("font-family", "Arial")
  #       .attr("font-size", "10px")
  #       .text( (d) -> d.scoreText)
  #         
  #   @get("entries-svg").selectAll("g.score-group circle.hitbox").data(controller.get("anchors")).enter()
  #     .append("circle")
  #       .attr
  #         class: "hitbox"
  #         r: (d) -> (that.get("width") / scoreCircle[0].length) / 2
  #         cx: (d) -> that.get("entriesX")(d.origin.x)
  #         cy: (d) -> that.get("entriesY")(d.origin.y)
  #         fill: "transparent"
  #       .on("mouseenter", (d,i) ->
  #         d3.select(scoreCircle[0][d.score_index]).transition()
  #           .duration(200)
  #           .attr("r", 30)
  #           .style("stroke-width", "3px")
  #           
  #         d3.select(scoreText[0][d.score_index]).transition()
  #           .duration(200)
  #           .attr("opacity", 1)
  #           .style("font-size", "20px")
  #           
  #       )
  #       .on("mouseleave", (d,i) ->  
  #       
  #         d3.select(scoreCircle[0][d.score_index]).transition()
  #           .duration(300)
  #           .attr("r", 6)
  #           .style("stroke-width", "2px")
  #           
  #         d3.select(scoreText[0][d.score_index]).transition()
  #           .duration(300)
  #           .attr("opacity", 0)
  #           .style("font-size", "10px")
  #       )
  #       .on("click", (d,i) -> d.model.goTo())
  # 
  #   circles = d3.selectAll("circle")
  #   links = @get("entries-svg").selectAll(".link").data(controller.get("links")).enter()
  #     .append("line")
  #       .attr("class", "link")
  #   
  #   @get("entries-svg").selectAll("circle.score")
  #     .attr(opacity: 0)
  #     
  #     
  #   scoreCircle
  #     .transition()
  #       .each("start", (d,i) -> d.fixed = false)
  #       .duration(2000)
  #       .delay((d,i) -> i*60)
  #       .attr
  #         opacity: 100
  #         r: 6
  #       
  #     
  #   @get("force").on "tick", (e) ->
  #     k = .2 * e.alpha
  #     
  #     scoreCircle.each (o, i) ->
  #       o.y += (o.origin.y - o.y) * k
  #       o.x += (o.origin.x - o.x) * k
  #     
  #     links
  #       .attr("x1", (d) -> d.source.x)
  #       .attr("y1", (d) -> d.source.y)
  #       .attr("x2", (d) -> d.target.x)
  #       .attr("y2", (d) -> d.target.y)
  #       
  #     scoreCircle
  #       .attr
  #         cx: (d) -> that.get("entriesX")(d.x)
  #         cy: (d) -> that.get("entriesY")(d.y)
  #         
  # renderMeds: ->
  #   @setupMeds()
  #   controller = @get("controller")
  #   that = @
  #   
  #   controller.get("medLines").forEach (medLine) ->
  #     
  #     line = d3.svg.line().x( (d) -> d.x ).y( (d) -> d.y )
  #   
  #     that.get("meds-svg").append("path")
  #       .datum(medLine)
  #       .attr("class", "med-line")
  #       .attr("d", line)
  #   
  #   medication = @get("meds-svg").selectAll("g.medication-group").data(controller.get("medications")).enter()
  #     .append("g")
  #       .attr(class: "medication-group")
  #       .on("mouseenter", (d,i) ->
  #         d3.select(this).select("text").transition()
  #           .duration(500)
  #           .attr
  #             "opacity": 1
  #             "dy": (d) -> d.y - 20
  #           .style("font-size", "15px")
  #       )
  #       .on("mouseleave", (d,i) ->
  #         d3.select(this).select("text").transition()
  #           .duration(10)
  #           .attr
  #             "opacity": 0
  #             "dy": (d) -> d.y
  #           
  #           .style("font-size", "10px")
  #       )
  #         
  #   medication.append("text")
  #     .attr
  #        class: "med-text"
  #        dx: (d) -> d.x
  #        dy: (d) -> d.y
  #        opacity: 0
  #     .style("text-anchor", "middle")
  #     .attr("font-family", "Arial")
  #     .attr("font-size", "10px")
  #     .text( (d) -> d.text)
  #     
  #   medication.append("circle")
  #     .attr
  #       class: (d) -> "medication med-level-#{d.medClass+1}"
  #       cx: (d) -> d.x
  #       cy: (d) -> d.y
  #       r: 5
