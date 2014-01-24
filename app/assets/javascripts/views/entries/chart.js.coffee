App.EntriesChartView = Em.View.extend
  classNames: "entries-chart"
  templateName: "entries/chart"
    
  didInsertElement: -> 
    @renderChart()

    # that = @
    # $(window).resize ->
    #   that.get("chart").configure(width: that.$(".chart").width())

  renderChart: ->
    
    that = @
    coordinates = @get("controller.user.cdai_score_coordinates")

    if coordinates
      $container  = $(".chart-container")
      margin      = {top: 50, right: 50, bottom: 50, left: 50}
      width       = $container.width() - margin.left - margin.right
      height      = $container.height() - margin.top - margin.bottom

      y = d3.scale.linear()
        .domain([d3.min(coordinates, (d) -> d.y), d3.max(coordinates, (d) -> d.y)])
        .range [height,0]
      x = d3.scale.linear()
        .domain([d3.min(coordinates, (d) -> d.x), d3.max(coordinates, (d) -> d.x)])
        .range [0, width]
      
      chartData = App.ChartDataController.create()
      coordinates.forEach (coord) ->
        chartData.addCoordinate coord, x, y, that.get("controller.target")
        
      force = d3.layout.force()
        .charge( (d) -> d.charge)
        .gravity(0)
        .linkDistance(1)
        .linkStrength(0.5)
        .size([width, height])

      svg = d3.select(".chart-container").append("svg")
        .attr("id", "chart")
        .attr("width", "100%")
        .attr("height", "100%")
        .attr("viewBox","0 0 #{width + margin.left + margin.right} #{height + margin.top + margin.bottom}" )
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

      svg.selectAll("line.horizontalGrid").data(y.ticks(6)).enter()
        .append("line")
          .attr
            "class" : "horizontalGrid"
            "x1" : 0
            "x2" : width
            "y1" : (d) -> y(d)
            "y2" : (d) -> y(d)
            "fill" : "none"
            "shape-rendering" : "crispEdges"
            "stroke" : "black"
            "stroke-width" : "1px"
            
      svg.selectAll("line.verticalGrid").data(x.ticks(12)).enter()
        .append("line")
          .attr
            "class" : "verticalGrid"
            "y1" : 0
            "y2" : height
            "x1" : (d) -> x(d)
            "x2" : (d) -> x(d)
            "fill" : "none"
            "shape-rendering" : "crispEdges"
            "stroke" : "black"
            "stroke-width" : "1px"
      
      startLine = d3.svg.line()
        .x( (d) -> d.x )
        .y( (d) -> height*2 )
        
      endLine = d3.svg.line()
        .x( (d) -> d.x )
        .y( (d) -> d.y )
      
      svg.append("path")
        .datum(chartData.get("anchors"))
        .attr("class", "line")
        .attr("d", startLine)
        .transition()
          .duration(1000)
          .attr("d", endLine)
        
      svg.append("path")
        .datum(chartData.get("fillCoordinates"))
        .attr("class", "chart-fill")
        .attr("d", startLine)
        .transition()
          .duration(1000)
          .attr("d", endLine)
          
      chartData.get("links")
         
      force
        .nodes(chartData.get("scores"))
        # .links(chartData.get("links"))
        .links([])
        .start()
              
      scoreCircle = svg.selectAll("g.score-group").data(chartData.get("scores")).enter()
        .append("circle")
          .attr
            class: "score"
            cx: (d) -> d.x
            cy: (d) -> d.y
            r: 3
          .call(force.drag)
      
      
      scoreText = svg.selectAll("g.score-group").data(chartData.get("scores")).enter()
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
      # svg.selectAll("g.score-group rect.barhitbox").data(chartData.get("anchors")).enter()
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
            
      svg.selectAll("g.score-group circle.hitbox").data(chartData.get("anchors")).enter()
        .append("circle")
          .attr
            class: "hitbox"
            r: (d) -> (width / scoreCircle[0].length) / 2
            cx: (d) -> d.x
            cy: (d) -> d.y
            fill: "transparent"
          .on("mouseenter", (d,i) ->  
          
            d3.select(scoreCircle[0][d.score_index]).transition()
              .duration(500)
              .attr("r", 30)
              
            d3.select(scoreText[0][d.score_index]).transition()
              .duration(500)
              .attr("opacity", 1)
              .style("font-size", "20px")
              
          )
          .on("mouseleave", (d,i) ->  
          
            d3.select(scoreCircle[0][d.score_index]).transition()
              .duration(1000)
              .attr("r", 10)
              
            d3.select(scoreText[0][d.score_index]).transition()
              .duration(1000)
              .attr("opacity", 0)
              .style("font-size", "10px")
          )
          .on("click", (d,i) -> d.model.goTo())

      circles = d3.selectAll("circle")
      links = svg.selectAll(".link").data(chartData.get("links")).enter()
        .append("line")
          .attr("class", "link")
      
      svg.selectAll("circle.score")
        .attr(opacity: 0)
        
        
      scoreCircle
        .transition()
          .each("start", (d,i) -> d.fixed = false)
          .duration(2000)
          .delay((d,i) -> i*60)
          .attr
            opacity: 100
            r: 10
          
        
      force.on "tick", (e) ->
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
          
  # watchChart: Ember.observer ->
  #   chart = @get("chart")
  #   if chart
  #     chart.series[0].data = @get("controller.score_coordinates")
  #     chart.update()
  #   
  # .observes("controller.score_coordinates")
