App.Score = DS.Model.extend
  name: DS.attr('string')
  value: DS.attr('number')
  
App.ScoreSerializer = DS.ActiveModelSerializer.extend
  primaryKey: "uuid"