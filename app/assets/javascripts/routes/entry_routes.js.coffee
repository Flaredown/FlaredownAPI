App.Router.map ->
  @resource "entries", path: "", ->
    @route "entry", path: "/entry/:date/:section"

App.ApplicationRoute = Em.Route.extend()

App.EntriesRoute = App.AuthenticatedRoute.extend
  model: (params) ->
    user = @controllerFor("user")
    ajax "/chart", {data: {start_date: user.get("defaultStartDate"), end_date: user.get("defaultEndDate")}}

  setupController: (controller,model) ->
    user = @controllerFor("user")
    controller.set("model", model.chart)
    controller.set("startDate", moment(user.get("defaultStartDate")))
    controller.set("endDate", moment(user.get("defaultEndDate")))

  enter: ->
    user_id = @controllerFor("login").get("loginId")
    @get("pusher").subscribe("entries_for_#{user_id}") if user_id
  exit: ->
    user_id = @controllerFor("login").get("loginId")
    @get("pusher").unsubscribe("entries_for_#{user_id}") if user_id
    
  actions:
    updates: (message) ->
      @controllerFor("entries").get("catalog.scores").pushObject {x: 1391922000, y: 500 }

App.EntriesEntryRoute = App.AuthenticatedRoute.extend
  model: (params, transition, queryParams) ->
    self = @
    date = params.date
    today = moment().format("MMM-DD-YYYY")
    @set "section", parseInt params.section
    
    date = today if params.date is "today" or today is params.date
  
    controller = @controllerFor("entries_entry")
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
