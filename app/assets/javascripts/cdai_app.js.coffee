window.attr      = DS.attr
window.belongsTo = DS.belongsTo
window.hasMany   = DS.hasMany

$.ajaxSetup
  contentType: "application/json; charset=utf-8"
  dataType: "json"
  beforeSend: (xhr, settings) ->        
    csrf_token = $('meta[name="csrf-token"]').attr('content');
    if csrf_token then xhr.setRequestHeader('X-CSRF-Token', csrf_token)
    if ( settings.contentType is "application/json; charset=utf-8" and typeof(settings.data) isnt "string" )
      settings.format = "json"
      settings.data = JSON.stringify(settings.data)
  
window.App = Ember.Application.create
  rootElement: "#ember-app"
  LOG_TRANSITIONS: true

App.ApplicationSerializer = DS.ActiveModelSerializer.extend()
App.ApplicationAdapter = DS.RESTAdapter.extend
  findQuery: (store, type, query) ->
    if (query.id)
      url = this.buildURL(type.typeKey, query.id)
      delete query.id
    else
      url = this.buildURL(type.typeKey)

    @ajax(url, 'GET', { data: query })
  
window.App.generalError = (message) ->
  unless message then message = "We've encountered an unexpected error! Please refresh the page and try again, if the error persists please contact support via the 'Contact Us' link."
  alert(message)