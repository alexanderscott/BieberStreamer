//= require jquery
//= require jquery_ujs
//= require_tree .
//= require moment
//= require underscore
//= require bootstrap

jQuery(document).ready(function() {
  var MAX_TWEETS_DISPLAYED = 100;
  
  function getTweetTpl(cb){
    $.ajax({
      type: 'GET',
      url: '/tweet.html.tpl',
      dataType: 'text',
      success: function(tplStr){ 
        cb(null, tplStr); 
      },
      error: cb
    });
  }

  getTweetTpl(function(err, tweetTplStr){
    if(err){
      console.log("Error fetching tweet template: ", err);
      return false;
    }

    var counter = 0;
    var source = new EventSource('/socket'), message;
    source.addEventListener('tweet', function (e) {
        console.log(e);
      var tweet = JSON.parse(e.data);

      tweet.user_image = tweet.user_image.scheme + '://' + tweet.user_image.host + tweet.user_image.path;
      tweet.timeago = moment(tweet.created_at).fromNow()

      $("#tweet-list").prepend("<li>" + _.template(tweetTplStr, { tweet : tweet }) + "</li>");

      if(counter > MAX_TWEETS_DISPLAYED) $("#tweet-list li:last-child").remove()  
      else counter++;

    });
  });
});
