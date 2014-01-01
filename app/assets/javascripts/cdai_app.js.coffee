window.attr      = DS.attr
window.belongsTo = DS.belongsTo
window.hasMany   = DS.hasMany

$.ajaxSetup
  beforeSend: (xhr, settings) ->        
    csrf_token = $('meta[name="csrf-token"]').attr('content');
    if csrf_token then xhr.setRequestHeader('X-CSRF-Token', csrf_token)

DS.rejectionHandler = (reason) ->
  if (reason.status is 401)
    App.Auth.destroy()
  throw reason
  
window.App = Ember.Application.create
  rootElement: "#ember-app"
  LOG_TRANSITIONS: true
  
window.App.generalError = (message) ->
  unless message then message = "We've encountered an unexpected error! Please refresh the page and try again, if the error persists please contact support via the 'Contact Us' link."
  alert(message)