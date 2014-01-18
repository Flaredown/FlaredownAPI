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

      $.ajax
        type: "POST"
        url: "/users.json"
        data: data
        contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        success: (response) ->
            self.set "controllers.login.loginId", response.id
            self.set "controllers.user.content", response
            self.reset()
            self.transitionToRoute('entries')
        error: (response) ->
            debugger
            errors = JSON.parse(response.responseText).errors
        
            for k,v of errors
              errors[k] = v[0]
          
            self.set("errors", errors)