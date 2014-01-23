App.ChartDatum = Em.Controller.extend
  datumText: Em.computed ->
    "#{moment(@get('x')).format('MM/DD')} - #{@get('y')}"
  .property("x", "y")
  
  entryDate: Em.computed -> 
    moment(@get("x")).format("MMM-DD-YYYY")
  .property("x")
  
  goTo: -> @transitionToRoute("entry", @get("entryDate"), 1)