App.EntriesChartView = Em.View.extend
  classNames: "entries-chart"
  templateName: "entries/chart"
    
  didInsertElement: -> 
    @renderChart()

    # that = @
    # $(window).resize ->
    #   that.get("chart").configure(width: that.$(".chart").width())
    
  renderChart: ->
    @$(".chart").html("")
    @$(".y-axis").html("")
    @$(".legend").html("")

    data = @get("controller.score_coordinates")
    unless Em.isEmpty(data)
      chart = new Rickshaw.Graph
        element: @$(".chart")[0]
        renderer: "line"
        interpolation: "linear"
        width: 1000
        height: 400
        min: 0
        series: [
          {
            name: "Score"
            data: data
            color: "#f39c12"
          }
        ]
        
      y_axis = new Rickshaw.Graph.Axis.Y
        graph: chart
        orientation: 'left'
        tickFormat: Rickshaw.Fixtures.Number.formatKMBT
        element: @$('.y-axis')[0]
        ticksTreatment: 'fancy'
      
      # x_axis = new Rickshaw.Graph.Axis.X
      #   graph: chart
      #   width: 1000
      #   element: @$('.x-axis')[0]
      #   tickFormat: (x) -> moment(new Date(x)).format("MM/DD")
      #   ticksTreatment: 'fancy'
            
      hoverDetail = new Rickshaw.Graph.HoverDetail
        graph: chart,
        xFormatter: (x) -> moment(new Date(x)).format("MM/DD")
        yFormatter: (y) -> y

      chart.offset   = "zero"
    
      chart.renderer.unstack  = false
      chart.renderer.offset  = false
    
      chart.render()
    
      @set("chart", chart)
      @watchChart()
      
  watchChart: Ember.observer ->
    chart = @get("chart")
    if chart
      chart.series[0].data = @get("controller.score_coordinates")
      chart.update()
    
  .observes("controller.score_coordinates")