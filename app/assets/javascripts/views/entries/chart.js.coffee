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
      coordinates = coordinates.map (coordinate) -> App.ChartDatum.create coordinate, target: that.get("controller.target")
    
      $container  = $(".chart-container")
      margin      = {top: 20, right: 10, bottom: 20, left: 10}
      width       = $container.width() - margin.left - margin.right
      height      = $container.height() - margin.top - margin.bottom

      y = d3.scale.linear()
        .domain([d3.min(coordinates, (d) -> d.y), d3.max(coordinates, (d) -> d.y)])
        .range [height,0]
      x = d3.scale.linear()
        .domain([d3.min(coordinates, (d) -> d.x), d3.max(coordinates, (d) -> d.x)])
        .range [0, width]

      svg = d3.select(".chart-container").append("svg")
        .attr("id", "chart")
        .attr("width", "100%")
        .attr("height", "100%")
        .attr("viewBox","0 0 #{width + margin.left + margin.right} #{height + margin.top + margin.bottom}" )
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

      svg.selectAll("line.horizontalGrid").data(y.ticks(20)).enter()
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
            
      svg.selectAll("line.verticalGrid").data(x.ticks(20)).enter()
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
      
      line = d3.svg.line()
        .x( (d) -> x(d.x) )
        .y( (d) -> y(d.y) )
        
      svg.append("path")
        .datum(coordinates)
        .attr("class", "line")
        .attr("d", line)
          
      circles = svg.selectAll("g.score-circle").data(coordinates).enter()
        .append("g")
          .attr
            class: "score-circle"
      circles.append("circle")
        .attr
          class: "score"
          cx: (d) -> x d.x
          cy: (d) -> y d.y
          r: 6
        
      circles.append("circle")
        .attr
          class: "hitbox"
          r: 40
          cx: (d) -> x d.x
          cy: (d) -> y d.y
          fill: "transparent"
        .on("mouseover", (d,i) -> d3.select(this.parentNode).select(".score").transition().attr("r", 9) )
        .on("mouseout", (d,i) -> d3.select(this.parentNode).select(".score").transition().attr("r", 6) )
        .on("click", (d,i) -> d.goTo())
      
            
      svg.selectAll("text.score-text").data(coordinates).enter()
       .append("text")
         .attr
           class: "score-text"
           dx: (d) -> x(d.x)+15
           dy: (d) -> y d.y
         .text (d) -> d.get("datumText")
         
  # watchChart: Ember.observer ->
  #   chart = @get("chart")
  #   if chart
  #     chart.series[0].data = @get("controller.score_coordinates")
  #     chart.update()
  #   
  # .observes("controller.score_coordinates")
