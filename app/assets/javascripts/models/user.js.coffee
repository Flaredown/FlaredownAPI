App.User = DS.Model.extend
  entries:  hasMany "entry"
  
  email:  attr "string"
  weight: attr "number"
  
  score_coordinates: attr "object"