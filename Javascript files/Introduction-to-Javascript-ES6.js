// var tweet = prompt("Compose your tweet: ");
// tweet.length;
// alert("You have written " + tweet.length + " characters, you have " + (140 - tweet.length) + " characters left.");

// var tweet = prompt("Compose your tweet: ");
// var tweetLimit = tweet.slice(0,140);
// var tweetCount = tweetLimit.length;
// alert("You have written " + tweetCount + " characters, you have " + (140 - tweetCount) + " characters left.");

var name = prompt("What is your name?")
var name = name.slice(0,1).toUpperCase() + name.slice(1, name.length).toLowerCase();
alert("Hello, " + name + "!");