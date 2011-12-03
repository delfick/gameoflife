(function() {
  var body;
  window.location = "javascript: function checkLogo(){}; function buildPage(){}; function biggercomment(){};";
  window.onload = function() {};
  document.onclick = function() {};
  $("head, style").empty();
  body = $("body");
  body.attr({
    onload: ""
  });
  $("script:last", body).addClass("activities_javascript");
  styler.setupOnPop();
  styler.start(body);
}).call(this);
