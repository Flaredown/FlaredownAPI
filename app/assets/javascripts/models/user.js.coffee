App.User = DS.Model.extend
  entries:  hasMany "entry"
  
  email:  attr "string"
  weight: attr "number"
  
  cdai_score_coordinates: attr ""