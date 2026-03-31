console.log("=== FUNCTION PRACTICE TEST ===");

//
// 1. Basic function
//
function sayHello() {
  console.log("Hello JS!");
}

console.log("1) sayHello():");
sayHello();


//
// 2. Function with 1 parameter
//
function greet(name) {
  console.log("Hello, " + name + "!");
}

console.log("\n2) greet():");
greet("Alex");
greet("Manila");


//
// 3. Function that RETURNS a value
//
function add(a, b) {
  return a + b;
}

console.log("\n3) add():", add(5, 9)); // Expect 14


//
// 4. Arrow function version of add()
//
const addArrow = (a, b) => a + b;

console.log("\n4) addArrow():", addArrow(10, 2)); // Expect 12


//
// 5. Check if a number is positive
//
function positive(num) {
  return num > 0;
}

console.log("\n5) positive():", positive(5), positive(-2));


//
// 6. Return the first character of a string
//
function firstChar(str) {
  return str[0];
}

console.log("\n6) firstChar():", firstChar("Hello"));


//
// 7. Arrow function for square
//
const square = (n) => n * n;

console.log("\n7) square():", square(6)); // Expect 36


//
// 8. Return the longer of two strings
//
function longer(a, b) {
  return a.length > b.length ? a : b;
}

console.log("\n8) longer():", longer("cat", "giraffe"));


//
// 9. Return "even" or "odd"
//
function evenOrOdd(n) {
  return n % 2 === 0 ? "even" : "odd";
}

console.log("\n9) evenOrOdd():", evenOrOdd(7), evenOrOdd(12));


//
// 10. CHALLENGE: repeat a word n times
//
function repeat(word, times) {
  return word.repeat(times);
}

console.log("\n10) repeat():", repeat("Hi", 3));