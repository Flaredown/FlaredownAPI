App.EntriesIndexRoute = App.AuthenticatedRoute.extend()
  # model: -> @store.find("entry")
  
App.EntriesNewRoute = App.AuthenticatedRoute.extend
  model: -> 
    self = @
    date = new Date("10/11/2020")
    # date = new Date()
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