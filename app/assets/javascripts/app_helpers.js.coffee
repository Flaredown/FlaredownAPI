window.uuid = (name, doc_id) ->
  "#{name}_#{doc_id}"
  
window.attr      = DS.attr
window.belongsTo = DS.belongsTo
window.hasMany   = DS.hasMany

$.ajaxSetup
  contentType: "application/json; charset=utf-8"
  dataType: "json"
  beforeSend: (xhr, settings) ->        
    csrf_token = $('meta[name="csrf-token"]').attr('content');
    if csrf_token then xhr.setRequestHeader('X-CSRF-Token', csrf_token)
    if ( settings.contentType is "application/json; charset=utf-8" and typeof(settings.data) isnt "string" )
      settings.format = "json"
      settings.data = JSON.stringify(settings.data)
      
window.App.generalError = (message) ->
  unless message then message = "We've encountered an unexpected error! Please refresh the page and try again, if the error persists please contact support via the 'Contact Us' link."
  alert(message)
    
moment.tz.add({
    "zones": {
        "America/New_York": [
            "-4:56:2 - LMT 1883_10_18_12_3_58 -4:56:2",
            "-5 US E%sT 1920 -5",
            "-5 NYC E%sT 1942 -5",
            "-5 US E%sT 1946 -5",
            "-5 NYC E%sT 1967 -5",
            "-5 US E%sT"
        ]
    },
    "rules": {
        "US": [
            "1918 1919 2 0 8 2 0 1 D",
            "1918 1919 9 0 8 2 0 0 S",
            "1942 1942 1 9 7 2 0 1 W",
            "1945 1945 7 14 7 23 1 1 P",
            "1945 1945 8 30 7 2 0 0 S",
            "1967 2006 9 0 8 2 0 0 S",
            "1967 1973 3 0 8 2 0 1 D",
            "1974 1974 0 6 7 2 0 1 D",
            "1975 1975 1 23 7 2 0 1 D",
            "1976 1986 3 0 8 2 0 1 D",
            "1987 2006 3 1 0 2 0 1 D",
            "2007 9999 2 8 0 2 0 1 D",
            "2007 9999 10 1 0 2 0 0 S"
        ],
        "NYC": [
            "1920 1920 2 0 8 2 0 1 D",
            "1920 1920 9 0 8 2 0 0 S",
            "1921 1966 3 0 8 2 0 1 D",
            "1921 1954 8 0 8 2 0 0 S",
            "1955 1966 9 0 8 2 0 0 S"
        ]
    },
    "links": {}
});