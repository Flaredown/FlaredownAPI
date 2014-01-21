App.Router.map ->
  @resource "entries", path: "/", ->
  @resource "entry", path: "/entry/:date/:section", ->

App.EntriesIndexRoute = App.AuthenticatedRoute.extend()
  # model: -> @store.find("entry")
  
App.EntryRoute = App.AuthenticatedRoute.extend

  model: (params, transition, queryParams) ->
    self = @
    date = params.date
    today = moment().format("MMM-DD-YYYY")
    @set "section", parseInt params.section
    
    date = today if params.date is "today" or today is params.date
  
    controller = @controllerFor("entry")
    if controller
      return controller.get("model") if controller.get("model.entryDate") is date
      
    $.get("entries/#{date}", {by_date: true}).then(
      (response) ->
        if response.id
          self.store.find("entry", response.id)
        else
          self.store.createRecord("entry", {catalogs: ["cdai"]}).save()
      ,
      (response) ->
        debugger
    )
    
  renderTemplate: (controller, model) ->
    model.set "section", @get("section")
    controller.setProperties
      "title": model.get("id")
      
    @render "entries/modal"
    
  actions:
    close: -> @transitionTo "entries.index"
