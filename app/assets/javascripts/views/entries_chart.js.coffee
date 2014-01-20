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
      coordinates = coordinates.map (coordinate) -> Em.Object.create coordinate
    
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
          
      svg.selectAll("circle.score").data(coordinates).enter()
        .append("circle")
          .attr
            class: "score"
            cx: (d) -> x d.x
            cy: (d) -> y d.y
            text: (d) -> d.x
            r: 6
          .on("click", (d,i) -> debugger)
          .on("mouseover", (d,i) -> d3.select(this).transition().attr("r", 9) )
          .on("mouseout", (d,i) -> d3.select(this).transition().attr("r", 6) )
        
            
      svg.selectAll("text.score-text").data(coordinates).enter()
       .append("text")
         .attr
           class: "score-text"
           dx: (d) -> x(d.x)+15
           dy: (d) -> y d.y
         .text (d) -> "#{moment(new Date(d.x)).format("MM/DD")} - #{d.y}"
         
      
         
      # text = svg.append("text")
      #   .text("0%")
      #   .attr("text-anchor", "middle")
      #   .style("font-size",fontSize+"px")
      #   .attr("dy",fontSize / 3)
      #   .attr("dx",2);
      
      # svg.selectAll(".vline").data(d3.range(coordinates.length)).enter()
      #     .append("line")
      #     .attr("x1", (d) -> return d * 40)
      #     .attr("x2", (d) -> return d * 40)
      #     .attr("y1", (d) -> return 0)
      #     .attr("y2", (d) -> return 500)
      #     .style("stroke", "#fff")
          
      
        
    # @$(".chart").html("")
    # @$(".y-axis").html("")
    # @$(".legend").html("")
    # 
    # data = @get("controller.score_coordinates")
    # unless Em.isEmpty(data)
    #   chart = new Rickshaw.Graph
    #     element: @$(".chart")[0]
    #     renderer: "line"
    #     interpolation: "linear"
    #     width: 1000
    #     height: 400
    #     min: 0
    #     series: [
    #       {
    #         name: "Score"
    #         data: data
    #         color: "#f39c12"
    #       }
    #     ]
    #     
    #   y_axis = new Rickshaw.Graph.Axis.Y
    #     graph: chart
    #     orientation: "left"
    #     tickFormat: Rickshaw.Fixtures.Number.formatKMBT
    #     element: @$(".y-axis")[0]
    #     ticksTreatment: "fancy"
    #   
    #   # x_axis = new Rickshaw.Graph.Axis.X
    #   #   graph: chart
    #   #   width: 1000
    #   #   element: @$(".x-axis")[0]
    #   #   tickFormat: (x) -> moment(new Date(x)).format("MM/DD")
    #   #   ticksTreatment: "fancy"
    #         
    #   hoverDetail = new Rickshaw.Graph.HoverDetail
    #     graph: chart,
    #     xFormatter: (x) -> moment(new Date(x)).format("MM/DD")
    #     yFormatter: (y) -> y
    # 
    #   chart.offset   = "zero"
    # 
    #   chart.renderer.unstack  = false
    #   chart.renderer.offset  = false
    # 
    #   chart.render()
    # 
    #   @set("chart", chart)
    #   @watchChart()
      
  watchChart: Ember.observer ->
    chart = @get("chart")
    if chart
      chart.series[0].data = @get("controller.score_coordinates")
      chart.update()
    
  .observes("controller.score_coordinates")