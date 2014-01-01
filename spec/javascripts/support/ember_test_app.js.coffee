window.attr      = DS.attr
window.belongsTo = DS.belongsTo
window.hasMany   = DS.hasMany

DS.rejectionHandler = (reason) ->
  if (reason.status is 401)
    App.Auth.destroy()
  throw reason

Ember.FEATURES["query-params"] = true

window.App = Ember.Application.create
  rootElement: "body"