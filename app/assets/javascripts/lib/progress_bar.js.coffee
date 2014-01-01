$(document).ajaxStart ->
  $("#progress").remove()
  if $("#progress").length is 0
    $("body").append($("<div><dt/><dd/></div>").attr("id", "progress"))
    $("#progress").width((50 + Math.random() * 30) + "%")

$(document).ajaxComplete ->
  # End loading animation
  $("#progress").width("110%") #.delay(200).fadeOut 400, 
  $("#progress").html("")