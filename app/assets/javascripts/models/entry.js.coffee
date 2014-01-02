App.Entry = DS.Model.extend
  user: belongsTo("user")
  
  score:  attr("number")
  date:   attr("date")
  
  stools:         attr("number")
  ab_pain:        attr("number")
  general:        attr("number")
  mass:           attr("number")
  hematocrit:     attr("number")
  mass:           attr("number")
  weight_current: attr("number")

  complication_arthritis: attr("boolean")
  complication_iritis:    attr("boolean")
  complication_erythema:  attr("boolean")
  complication_fistula:   attr("boolean")
  complication_fever:     attr("boolean")
  opiates:                attr("boolean")