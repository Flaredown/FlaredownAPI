App.Response = DS.Model.extend
  value:  attr()
  
App.ResponseSerializer = DS.ActiveModelSerializer.extend
  primaryKey: "uuid"