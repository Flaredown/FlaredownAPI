window.App = Ember.Application.create
  rootElement: "#ember-app"
  LOG_TRANSITIONS: true
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  

App.ApplicationSerializer = DS.ActiveModelSerializer.extend()