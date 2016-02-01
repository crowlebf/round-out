$(document).ready(function() {

  $("#comment-submit").on("click", function(event) {
  event.preventDefault();
    var urlID = window.location.href;
    var delimeter = "/";
    var string = urlID;
    var splat = string.split(delimeter);
    var id = splat[4];

    var body = document.getElementById("comment-ajax").value;
    var user = gon.user;
    var request = $.ajax({
      type: "POST",
      url: "/api/v1/comments/create",
      dataType: "json",
      data:
        { body: body,
          id: id
        }
      });
      request.success(function(response) {
        var divElement = document.getElementById("all-comments");
        var name = document.createElement("p");
        var paraName = document.createTextNode(gon.user);
        var para = document.createElement("p");
        var paraText = document.createTextNode(body);
        name.appendChild(paraName);
        para.appendChild(paraText);
        divElement.appendChild(name);
        divElement.appendChild(para);
        $("#comment-ajax").val("");
      });
      request.fail(function(response) {
    });
  });
});
