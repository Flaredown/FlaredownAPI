window.requireLogin = false
App.AuthenticatedRoute.reopen
  beforeModel: (transition) ->
    login = @controllerFor('login')
    if requireLogin and not login.get("isAuthenticated")
      @redirectToLogin(transition)
      
  redirectToLogin: (transition) ->
    loginController = @controllerFor('login')
    loginController.set('attemptedTransition', transition)
    @transitionTo('login')