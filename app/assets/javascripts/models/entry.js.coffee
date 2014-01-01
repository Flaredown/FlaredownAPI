App.Entry = DS.Model.extend
  user: belongsTo("user")
  
  score: attr("number")
  date: attr("date")