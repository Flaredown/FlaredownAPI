App.EntriesIndexController = Em.ArrayController.extend
  sortProperties: ["jsDate"]
  sortAscending: true
  
  savedEntries: Em.computed ->
    @get("arrangedContent").rejectBy("id", null)
  .property("@each")
  
  chartData: Em.computed ->
    @get("savedEntries").map((entry, i) -> {x: entry.get("jsDate"), y: entry.get("score")})
    # @get("savedEntries").map((entry, i) -> {x: i, y: entry.get("score")})
  .property("savedEntries")