App.Router.map ->
  @resource "entries", path: "/", ->
  @route "entry", path: "/entry/:date/:section"


App.ApplicationRoute = Em.Route.extend
  enter: -> 
    console.log "doing pusher stuff"
    @get("pusher").subscribe("entries_for_#{@controllerFor("login").get("loginId")}")
  actions:
    updates: (data) -> console.log data
  
App.EntriesIndexRoute = App.AuthenticatedRoute.extend()


App.EntryRoute = App.AuthenticatedRoute.extend
  model: (params, transition, queryParams) ->
    self = @
    date = params.date
    today = moment().format("MMM-DD-YYYY")
    @set "section", parseInt params.section
    
    date = today if params.date is "today" or today is params.date
  
    controller = @controllerFor("entry")
    if controller and controller.get("model.entryDate") is date
      controller.get("model")
    else      
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
    
  afterModel: (model, transition, params) ->
    model.set("section", @get("section"))
    
    # Insert all possible responses for forms to depend on
    model.get("questions").forEach (question) ->
      _uuid = uuid question.get("name"), model.get("id")
      response = model.get("responses").findBy("id", _uuid )
      if response
        response.set("question", question)
      else
        model.get("responses").createRecord({id: _uuid , name: question.get("name"), value: null, question: question})
    
  actions:
    close: -> @transitionTo "entries.index"