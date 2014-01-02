App.EntriesIndexController = Em.ArrayController.extend
  sortProperties: ["created_at"]
  sortAscending: true
  
  savedEntries: Em.computed ->
    @get("arrangedContent").rejectBy("id", null)
  .property("@each")