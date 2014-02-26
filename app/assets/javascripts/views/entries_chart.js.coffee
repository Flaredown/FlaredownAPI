App.EntriesChartView = Em.View.extend
  templateName: "entries/chart"
  
  watchScores: Em.observer ->
    that = @
    Ember.run.next -> that.renderChart()
  .observes("controller.scores").on("didInsertElement")
  
  x: Em.computed -> 
    d3.scale.linear()
      .domain([d3.min(@get("controller.scores"), (d) -> d.origin.x), d3.max(@get("controller.scores") , (d) -> d.origin.x)])
      .range [0, @get("width")]
  .property("width", "controller.scores.@each")
  
  y: Em.computed -> 
    d3.scale.linear()
      .domain([d3.min(@get("controller.scores") , (d) -> d.origin.y), d3.max(@get("controller.scores") , (d) -> d.origin.y)])
      .range [@get("height"),0]
  .property("height", "controller.scores.@each")
  
  fillCoordinates: Em.computed ->
    floor = @get("y")(@get("y").domain()[0])
    [
      Em.Object.create({id: -1, x: @get("controller.scores.firstObject.x"), y: floor, origin: {y: -floor}})
    ].concat(@get("controller.scores"))
    .concat(Em.Object.create({id: @get("controller.scores.lastObject.id")+1, x: @get("controller.scores.lastObject.x"), y: floor, origin: {y: -floor}}))
  .property("controller.scores.@each")
  
  setup: ->
    that = @
    controller = @get("controller")

    @set "container", $(".chart-container")
    @set "margin", {top: 50, right: 50, bottom: 50, left: 50}
    @set "width", @get("container").width() - @get("margin").left - @get("margin").right
    @set "height", @get("container").height() - @get("margin").top - @get("margin").bottom
    @set("force", d3.layout.force()
      .charge( (d) -> d.charge)
      .gravity(0)
      .linkDistance(1)
      .linkStrength(0.5)
      .size([@get("width"), @get("height")])
      .on("tick", @tick(@))
    )

    @set("svg", d3.select(".chart-container").append("svg")
      .attr("id", "chart")
      .attr("width", "100%")
      .attr("height", "100%")
      .attr("viewBox","0 0 #{@get("width") + @get("margin").left + @get("margin").right} #{@get("height") + @get("margin").top + @get("margin").bottom}" )
      .append("g")
        .attr("transform", "translate(" + @get("margin").left + "," + @get("margin").top + ")"))
    
    @get("svg").selectAll("line.horizontalGrid").data(@get("y").ticks(3)).enter()
      .append("line")
        .attr
          "class" : "horizontalGrid"
          "x1" : 0
          "x2" : @get("width")
          "y1" : (d) -> that.get("y")(d)
          "y2" : (d) -> that.get("y")(d)
          "fill" : "none"
          "shape-rendering" : "crispEdges"
          "stroke" : "black"
          "stroke-width" : "1px"
          
    @get("svg").selectAll("line.verticalGrid").data(@get("x").ticks(10)).enter()
      .append("line")
        .attr
          "class" : "verticalGrid"
          "y1" : 0
          "y2" : @get("height")
          "x1" : (d) -> that.get("x")(d)
          "x2" : (d) -> that.get("x")(d)
          "fill" : "none"
          "shape-rendering" : "crispEdges"
          "stroke" : "black"
          "stroke-width" : "1px"
          
    @set("startLine", d3.svg.line()
      .x( (d) -> d.x )
      .y( (d) -> that.get("height")*2 )
    )
      
    @set("endLine", d3.svg.line()
      .x( (d) -> d.x )
      .y( (d) -> that.get("y")(d.origin.y) )
    )
      
  tick: (that) ->
      (e) ->
        k = 0.2 * e.alpha
            
        
        that.get("svg").selectAll("circle.score").each (d,i) ->
          
          # if isNaN(d.x) or isNaN(d.y)
          #   # circle = d3.select(that.get("svg").selectAll("circle.score")[0][i])
          #   # d.x = parseFloat( if circle.attr("cx") then circle.attr("cx") else d.px )
          #   # d.y = parseFloat( if circle.attr("cy") then circle.attr("cy") else d.py )
          #   # # d.y = parseFloat(circle.attr("cy")
          #   # debugger if isNaN(d.x)
          #   debugger
          #   circle = d3.select(that.get("svg").selectAll("circle.score")[0][i])
          #   d.x = parseFloat circle.attr("cx")
          #   d.y = parseFloat circle.attr("cy")
            
          d.y += (that.get("y")(d.origin.y) - d.y) * k
          d.x += (that.get("x")(d.origin.x) - d.x) * k
    
        # that.get("links")
        #   .attr("x1", (d) -> d.source.x)
        #   .attr("y1", (d) -> d.source.y)
        #   .attr("x2", (d) -> d.target.x)
        #   .attr("y2", (d) -> d.target.y)
        
        that.get("svg").selectAll("circle.score")
          .attr
            cx: (d) -> d.x
            cy: (d) -> d.y
          
  update: (first) ->
    that = @
    controller = @get("controller")
    
    # @set("links", @get("svg").selectAll(".link").data(@get("controller").get("links"), (d) -> "#{d.source.id}-#{d.target.id}").enter()
    #   .append("line")
    #     .attr("class", "link")
    # )
    

  
    scoreCircle = @get("svg").selectAll("circle.score").data(controller.get("scores"), (d) -> d.id)
    scoreCircle.order()
      
    scoreCircle
      .enter()
        .append("circle")
          .datum( (d) ->
            d.set("x", that.get("x")(d.startx))
            d.set("y", that.get("y").domain()[0]+100)
          )
          .attr
            class: "score"
            r: 3
            opacity: 0
      
    scoreCircle
      .each (d,i) ->
        if typeof(d.x) is "undefined"
          circle = d3.select(that.get("svg").selectAll("circle.score")[0][i])
          d.x = parseFloat circle.attr("cx")
          d.y = parseFloat circle.attr("cy")

      .transition()
        .each("start", (d,i) -> d.fixed = false)
        # .each("end", (d,i) -> that.get("force").stop())
        .duration(2000)
        .delay((d,i) -> i*60)
        .attr
          opacity: 100
          r: 6

    scoreCircle
      .exit()
      
      .transition()
        .each("start", (d,i) -> d.fixed = true)
        .duration(300)
        .attr(
          cy: -1000
          opacity: 0
          cx: (d) -> d.x
        )
        .remove()
        
    scoreText = @get("svg").selectAll("text.score-text").data(controller.get("scores"), (d) -> d.id)
    scoreText
      .exit()
        .remove()
        
    scoreText
      .enter()
        .append("text")
          .attr
             class: "score-text"
          .style("text-anchor", "middle")
          .attr("font-family", "Arial")
          .attr("font-size", "10px")
          .text( (d) -> d.scoreText)
          
    scoreText
      .attr
         dx: (d) -> that.get("x")(d.origin.x)
         dy: (d) -> that.get("y")(d.origin.y) + 8
         opacity: 0

    hitbox = @get("svg").selectAll("circle.hitbox").data(controller.get("scores"), (d) -> d.id)

    hitbox
      .exit()
        .remove()
        
    hitbox
      .enter()
        .append("circle")
          .attr
            class: "hitbox"
        
    hitbox
      .attr
        r: (d) -> (that.get("width") / scoreCircle[0].length) / 2
        cx: (d) -> that.get("x")(d.origin.x)
        cy: (d) -> that.get("y")(d.origin.y)
        fill: "transparent"
      .on("mouseenter", (d,i) ->
        d3.select(scoreCircle[0][d.index]).transition()
          .duration(200)
          .attr("r", 30)
          .style("stroke-width", "3px")
      
        d3.select(scoreText[0][d.index]).transition()
          .duration(200)
          .attr("opacity", 1)
          .style("font-size", "20px")
      )
      .on("mouseleave", (d,i) ->  
  
        d3.select(scoreCircle[0][d.index]).transition()
          .duration(300)
          .attr("r", 6)
          .style("stroke-width", "2px")
      
        d3.select(scoreText[0][d.index]).transition()
          .duration(300)
          .attr("opacity", 0)
          .style("font-size", "10px")
      )
      .on("click", (d,i) -> d.model.goTo())
      
      # .each (d,i) ->
      #   hitbox = d3.select(that.get("svg").selectAll("circle.hitbox")[0][i])
      #   d.x = parseFloat hitbox.attr("cx")
      #   d.y = parseFloat hitbox.attr("cy")
        
        
    @get("force").nodes(controller.get("scores"), (d) -> d.id )
    Em.A(@get("force").nodes()).sortBy("id").forEach (d,i) ->
      if isNaN(d.x) or isNaN(d.y)
        circle = d3.select(that.get("svg").selectAll("circle.score")[0][i])
        d.x = parseFloat circle.attr("cx")
        d.y = parseFloat circle.attr("cy")
    
    # if @get("chartLine")
    #   @get("svg").selectAll("path.chart-line")
    #     .datum(controller.get("scores"))
    #     .transition()
    #       .duration(1000)
    #       .attr("d", @get("endLine"))
    #       
    #   @get("svg").selectAll("path.chart-fill")
    #     .datum(@get("fillCoordinates"))
    #     .transition()
    #       .duration(1000)
    #       .attr("d", @get("endLine"))
    #     
    # else
    #   @set("chartLine", @get("svg").append("path")
    #     .datum(controller.get("scores"))
    #     .attr("class", "chart-line")
    #     .attr("d", @get("startLine"))
    #     .transition()
    #       .duration(1000)
    #       .attr("d", @get("endLine"))
    #   )
    #   
    #   @set("chartFill", @get("svg").append("path")
    #     .datum(@get("fillCoordinates"))
    #     .attr("class", "chart-fill")
    #     .attr("d", @get("startLine"))
    #     .transition()
    #       .duration(1000)
    #       .attr("d", @get("endLine"))
    #   )
    
    @get("force").start()
    
  renderChart: ->      
    first = Em.isEmpty @get("svg")
    @setup() if first
    @update(first)
    
    
    