if rails_env isnt "test"
  Ember.Application.initializer
    name: "pusher"
  
    initialize: (container, application) ->  
      # use the same instance of Pusher everywhere in the app
      container.optionsForType('pusher', { singleton: true })

      # register 'pusher:main' as our Pusher object
      container.register('pusher:main', application.Pusher)

      # inject the Pusher object into all controllers and routes
      container.typeInjection('controller', 'pusher', 'pusher:main')
      container.typeInjection('route', 'pusher', 'pusher:main')