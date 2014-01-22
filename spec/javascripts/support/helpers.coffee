window.lookupStore      = -> App.__container__.lookup "store:main"
window.lookupRouter     = -> App.__container__.lookup "router:main"
window.lookupController = (name) -> App.__container__.lookup "controller:#{name}"
window.fakeServer       = -> sinon.fakeServer.create()