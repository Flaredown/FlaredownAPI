window.App = Ember.Application.create
  rootElement: "#ember-app"
  LOG_TRANSITIONS: true

App.ApplicationSerializer = DS.ActiveModelSerializer.extend()

