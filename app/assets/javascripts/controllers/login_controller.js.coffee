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
      
  redirectToTransition: ->
    attemptedTransition = @get('attemptedTransition')
    if attemptedTransition and attemptedTransition.targetName isnt "index"
      attemptedTransition.retry()
      @set('attemptedTransition', null)
    else 
      # @transitionToRoute('entries')
      @transitionToRoute('entries', @get("controllers.user.defaultStartDate"), @get("controllers.user.defaultEndDate"))
    
  credentialsObserver: Em.observer ->
    if Ember.isEmpty(@get('loginId'))
      $.removeCookie('loginId')
    else
      $.cookie('loginId', @get('loginId'))
  .observes('loginId')
  
  actions:
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
      @set('errorMessage', null)

      $.ajax
        type: "POST"
        url: "/users/sign_in.json"
        data: {user: data}
        contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        success: (response) ->
          self.set 'loginId', response.id
          self.set "controllers.user.content", response
          self.redirectToTransition()
        error: (response) ->
          $.removeCookie('loginId')
          self.set('errorMessage', JSON.parse(response.responseText).error)