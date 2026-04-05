// var tweet = prompt("Compose your tweet: ");
// tweet.length;
// alert("You have written " + tweet.length + " characters, you have " + (140 - tweet.length) + " characters left.");

// var tweet = prompt("Compose your tweet: ");
// var tweetLimit = tweet.slice(0,140);
// var tweetCount = tweetLimit.length;
// alert("You have written " + tweetCount + " characters, you have " + (140 - tweetCount) + " characters left.");

// var name = prompt("What is your name?")
// var name = name.slice(0,1).toUpperCase() + name.slice(1, name.length).toLowerCase();
// alert("Hello, " + name + "!");

// var dogAge = prompt("How old is your dog?")
// var humanAGe = (dogAge - 2) * 4 + 21;
// alert("Your dog is " + humanAGe + " years old in human years.");

function getMilk(money) { 
  var numberOfBottles = Math.floor(money / 1.49);
  var change = money % 1.49;
  console.log("buy " + numberOfBottles + " bottles of milk using $" + money + " of money");
  return money % 1.49;
}

var change = getMilk(5);
console.log("The change is $" + change + ".");    

// function lifeInWeeks(age) {
    
//     var yearsLeft = 90 - age;
//     var days = yearsLeft * 365;
//     var weeks = yearsLeft * 52;
//     var months = yearsLeft * 12;

//     console.log("You have " + days + " days, " + weeks + " weeks, and " + months + " months left.");
    
// }

// lifeInWeeks(24);