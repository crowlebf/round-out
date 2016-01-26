// $(document).ready(function() {
//
// $("#comment-submit").on("click", function(event) {
//   event.preventDefault();
//
//   var body = document.getElementById("comment-booty");
//
//   debugger;
//   var response = $.ajax({
//     type: "POST",
//     url: "/api/v1/comments",
//     dataType: "json",
//     data: {
//       comment: {
//         body: body
//       }
//     },
//     success: function(response) {
//       $("#comment-body").html(response);
//     }
//   });
//   return false;
// });
// });
