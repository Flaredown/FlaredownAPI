App.AuthenticatedController = Ember.Controller.extend App.LoginStatusMixin,
  needs: ["user"]
  
  userBinding: "controllers.user"
  