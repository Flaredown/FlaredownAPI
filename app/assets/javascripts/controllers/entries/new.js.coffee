App.EntriesNewController = Em.ObjectController.extend
  needs: ["user"]
    
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
          console.log response.id
        error: (response) ->
          debugger