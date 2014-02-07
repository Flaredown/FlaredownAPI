App.Pusher = Ember.Object.extend(
  key: window.bootstrap_pusher_key
  init: ->
    _this = this
    @service = new Pusher(@get("key"))
    @service.connection.bind "connected", ->
      _this.connected()
      return

    @service.bind_all (eventName, data) ->
      _this.handleEvent eventName, data
      return

    return

  connected: ->
    @socketId = @service.connection.socket_id
    @addSocketIdToXHR()
    return

  
  # add X-Pusher-Socket header so we can exclude the sender from their own actions
  # http://pusher.com/docs/server_api_guide/server_excluding_recipients
  addSocketIdToXHR: ->
    _this = this
    Ember.$.ajaxPrefilter (options, originalOptions, xhr) ->
      xhr.setRequestHeader "X-Pusher-Socket", _this.socketId

    return

  subscribe: (channel) ->
    @service.subscribe channel

  unsubscribe: (channel) ->
    @service.unsubscribe channel

  handleEvent: (eventName, data) ->
    router = undefined
    unhandled = undefined
    
    # ignore pusher internal events
    return  if eventName.match(/^pusher:/)
    router = @get("container").lookup("router:main")
    try
      router.send eventName, data
    catch e
      unhandled = e.message.match(/Nothing handled the event/)
      throw e  unless unhandled
    return
)
Ember.ControllerMixin.reopen pusher: null