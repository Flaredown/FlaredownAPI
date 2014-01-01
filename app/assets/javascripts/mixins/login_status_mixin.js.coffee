App.LoginStatusMixin = Ember.Mixin.create
  needs: "login"
  
  loggedIn: Em.computed ->
    @get("controllers.login.isAuthenticated")
  .property("controllers.login.isAuthenticated")