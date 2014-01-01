App.ApplicationController = Ember.Controller.extend App.LoginStatusMixin,
  needs: ["user"]

  userBinding: "controllers.user"
  
  actions:
    logout: ->
      @get("controllers.login").logout()
      @transitionToRoute('login')
