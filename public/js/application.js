$(document).ready(function() {
  $(".cvote").click(function(event){
    event.preventDefault();
    var val = $(this).attr('value');
    $.post("/createcvote", {comment_id: val}, function(response){
      $("#vote_count_" + val).text(response);
    });
  });
  $(".vote").click(function(event){
    event.preventDefault();
    var val = $(this).attr('value');
    $.post("/createvote", {post_id: val}, function(response){
      $("#vote_count_" + val).text(response);
    });
  });
});
