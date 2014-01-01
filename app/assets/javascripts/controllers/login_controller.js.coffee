App.LoginController = Ember.Controller.extend
  needs: ["user"]
  
  loginId: null
  
  isAuthenticated: Em.computed ->
    !Ember.isEmpty(@get("loginId"))
  .property("loginId")

  reset: ->
    @setProperties
      email: ""
      password: ""
      errorMessage: ""

  logout: -> 
    @set('loginId', null)
    self = this 
    $.ajax
      url: "/users/sign_out.json"
      type: "DELETE"
      success: (response) ->
        self.transitionToRoute("login")

    
  login: ->
    self = this
    data = @getProperties('email', 'password')
    
    # // Clear out any error messages.
    this.set('errorMessage', null)

    $.post('/users/sign_in.json', {user: data}).then(
      (response) ->
        self.set 'loginId', response.id
        self.set "controllers.user.content", response
        self.redirectToTransition()
      ,
      (response) ->
        $.removeCookie('loginId')
        self.set('errorMessage', JSON.parse(response.responseText).error)
    )
      
  redirectToTransition: ->
    attemptedTransition = @get('attemptedTransition')
    if attemptedTransition and attemptedTransition.targetName isnt "index"
      attemptedTransition.retry()
      @set('attemptedTransition', null)
    else 
      @transitionToRoute('entries')
    
  credentialsObserver: Em.observer ->
    if Ember.isEmpty(@get('loginId'))
      $.removeCookie('loginId')
    else
      $.cookie('loginId', @get('loginId'))
  .observes('loginId')