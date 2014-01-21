App.EntryController = Em.ObjectController.extend
  needs: ["user"]
  
  sectionChanged: Em.observer ->
    if @get("section")
      @transitionToRoute("entry.index", @get("entryDateParam"), @get("section"))
  .observes("section")
    
  actions:
    save: ->
      that = @
      
      data = 
        entry:
            responses: @get("responsesData")
      
      $.ajax
        url: "/entries/#{@get('id')}.json"
        type: "PATCH"
        data: JSON.stringify data
        success: (response) -> 
          null
        error: (response) ->
          debugger