App.RegisterController = Ember.Controller.extend
  needs: ["login", "user"]
  
  # genderOptions: ["male", "female"]
  genderOptions: [
    { label: "Male", value: "male"},
    { label: "Female", value: "female"}
  ]
  
  errors: {}
  
  reset: ->
    @setProperties
      email: ""
      password: ""
      password_confirmation: ""
      weight: ""

  actions:
    register: ->
      self = @
      data = {user: @getProperties("email", "password", "password_confirmation", "weight", "gender")}

      @set('errors', {})

      $.post('/users.json', data).then(
        (response) ->
          self.set "controllers.login.loginId", response.id
          self.set "controllers.user.content", response
          self.reset()
          self.transitionToRoute('entries')
        ,
        (response) ->
          errors = JSON.parse(response.responseText).errors
        
          for k,v of errors
            errors[k] = v[0]
          
          self.set("errors", errors)
        )