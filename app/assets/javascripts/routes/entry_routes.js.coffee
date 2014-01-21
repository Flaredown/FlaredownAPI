App.EntriesIndexRoute = App.AuthenticatedRoute.extend()
  # model: -> @store.find("entry")
  
App.EntriesEntryRoute = App.AuthenticatedRoute.extend
  renderTemplate: (controller, model) ->
    controller.set("title", model.get("id"))
    @render "entries/modal"
    
  model: (params, transition, queryParams) ->
    self = @
    date = null
    
    if params.date is "today"
      date = new Date();
    else
      date = new Date(params.date);
      
    $.get("entries/#{date.toDateString()}", {by_date: true}).then(
      (response) ->
        if response.id
          self.store.find("entry", response.id)
        else
          self.store.createRecord("entry", {catalogs: ["cdai"]}).save()
      ,
      (response) ->
        debugger
    )
    
  actions:
    close: -> @transitionTo "entries.index"