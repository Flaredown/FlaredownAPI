App.EntriesIndexRoute = App.AuthenticatedRoute.extend
  model: -> @store.find("entry")
  
App.EntriesNewRoute = App.AuthenticatedRoute.extend
  model: -> @store.createRecord("entry")