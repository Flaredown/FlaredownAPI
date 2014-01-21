// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require lib/jquery-2.0.3
//= require lib/jquery.cookie
//= require lib/moment.min
//= require lib/progress_bar

//= require lib/d3.v3.min
//= require lib/rickshaw.custom

// BOOTSTRAP
//= require bootstrap/modal
//= require bootstrap/dropdown

// EMBER
//= require lib/handlebars-v1.1.2
//= require lib/ember
// require lib/ember_canary
// require lib/ember-data
//= require lib/ember-data-canary
// require lib/ember-couchdb-kit/ember-couchdb-kit

//= require_tree ./templates

//= require cdai_app

//= require_tree ./routes
//= require_tree ./mixins
//= require_tree ./models
//= require_tree ./views

//= require_tree ./controllers
//= require_tree ./components
//= require_tree ./initializers