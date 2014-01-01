Ember.Application.initializer
  name: "bootstrap"
 
  initialize: (container, application) ->

    if window.current_user
      login = container.lookup("controller:login")
      login.set "loginId", window.current_user.id
      login.set "controllers.user.content", window.current_user