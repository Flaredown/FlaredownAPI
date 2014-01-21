App.ChartDatum = Em.Controller.extend
  datumText: Em.computed ->
    "#{moment(new Date(@get('x'))).format('MM/DD')} - #{@get('y')}"
  .property("x", "y")
  
  entryDate: Em.computed -> 
    moment(new Date(@get("x"))).format("MM-DD-YYYY")
  .property("x")
  
  goTo: -> @transitionToRoute("entries.entry", @get("entryDate"))