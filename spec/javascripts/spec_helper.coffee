# = require lib/jquery-2.0.3
# = require lib/jquery.cookie
# = require lib/moment.min
# = require lib/moment-timezone
# = require lib/progress_bar
# = require lib/d3.v3.min

# BOOTSTRAP
# = require bootstrap/modal
# = require bootstrap/dropdown

# EMBER
# = require lib/handlebars-v1.1.2

#  require lib/ember-canary
# = require lib/ember-1.4b3
#  require lib/ember-1.3.1
#  require lib/ember-1.2.0

# = require lib/ember-data-canary

# = require_tree ../../app/assets/javascripts/templates

# = require support/bootstrap

# = require ../../app/assets/javascripts/cdai_app
# = require ../../app/assets/javascripts/app_helpers

# = require_tree ../../app/assets/javascripts/routes
# = require support/no_login_required

# = require_tree ../../app/assets/javascripts/mixins
# = require_tree ../../app/assets/javascripts/models
# = require_tree ../../app/assets/javascripts/controllers
#  require_tree ../../app/assets/javascripts/components
# = require_tree ../../app/assets/javascripts/initializers
#  require_tree ../../app/assets/javascripts/components
#  require_tree ../../app/assets/javascripts/helpers
# = require_tree ../../app/assets/javascripts/views

# = require_tree ./fixtures

# = require support/adapter
# = require support/sinon-1.7.3
# = require support/helpers
# = require support/chai
# = require support/chai-jquery
window.expect = chai.expect

document.write('<div id="ember-testing-container"><div id="ember-testing"></div></div>');
document.write('<style>#ember-testing-container { position: absolute; background: white; bottom: 0; right: 0; width: 640px; height: 384px; overflow: auto; z-index: 9999; border: 1px solid #ccc; } .ember-test { zoom: 50%; }</style>');
App.rootElement = '#ember-testing'

Ember.Test.adapter = Ember.Test.MochaAdapter.create()

# This hook defers the readiness of the application, so that you can start 
# the app when your tests are ready to run. It also sets the router's location
# to 'none', so that the window's location will not be modified (preventing 
# both accidental leaking of state between tests and interference with your testing framework).
App.setupForTesting()

# visit(url)
# Visits the given route and returns a promise that fulfills when all resulting async behavior is complete.

# find(selector, context)
# Finds an element within the app's root element and within the context (optional). Scoping to the root element is especially useful to avoid conflicts with the test framework's reporter.

# fillIn(input_selector, text)
# Fills in the selected input with the given text and returns a promise that fulfills when all resulting async behavior is complete.

# click(selector)
# Clicks an element and triggers any actions triggered by the element's click event and returns a promise that fulfills when all resulting async behavior is complete.

# keyEvent(selector, type, keyCode)
# Simulates a key event type, e.g. keypress, keydown, keyup with the desired keyCode on element found by the selector.

# wait()
# Returns a promise that fulfills when all async behavior is complete.
App.injectTestHelpers()

# Prevent the router from manipulating the browser's URL.
# App.Router.reopen location: 'none'

# Useful for placing local test vars
window.Test ||= {}
# Shorthand
window.T = Test

beforeEach (done) ->
  Ember.run -> 
    console.log "\n----- RESET -----\n"
    App.reset()
    
  # Prevent automatic scheduling of runloops. For tests, we
  # want to have complete control of runloops.
  Ember.testing = true

  # reset all test variables!
  window.Test = {}
  
  T.store   = lookupStore()
  T.router  = lookupRouter()
  T.server  = fakeServer()
  # T.server.autoRespond = true
  
  Ember.run ->
    # Advance App readiness, which was deferred when the app
    # was created.

    # This needs to be done here, after each iframe has been setup,
    # instead of in a global `before`.
    App.advanceReadiness()

    # When App readiness promise resolves, setup is complete
    App.then ->
      done()

afterEach ->
  # reset all test variables!
  window.Test = {}

  # Restore XHR
  T.server.restore()

all -> Ember.testing = false