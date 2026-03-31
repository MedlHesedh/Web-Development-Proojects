console.log("=== FUNCTION PRACTICE TEST ===");

//
// 1. Basic function
// Create a function called sayHello that prints:
// "Hello JS!"
//
function sayHello() {
  console.log("Hello JS!");
}

console.log("1) sayHello():");
sayHello();


//
// 2. Function with 1 parameter
// Create a function greet(name) that prints:
// "Hello, <name>!"
//
function greet(name) {
  console.log("Hello " + name + "!");

}

console.log("\n2) greet():");
greet("Alex");
greet("Manila");


//
// 3. Function that RETURNS a value
// Create a function add(a, b)
// Return the sum.
//
function add(a, b) {
  return a + b;
}

console.log("\n3) add():", add(5, 9)); // Expect 14


//
// 4. Arrow function version of add()
// Write: const addArrow = (a, b) => ??? 
//
const addArrow = (a, b) =>  a + b;

console.log("\n4) addArrow():", addArrow(10, 2)); // Expect 12


//
// 5. Function that checks if a number is positive
// positive(5) → true
// positive(-2) → false
//
function positive(num) {
  return num > 0;
}

console.log("\n5) positive():", positive(5), positive(-2));


//
// 6. Function that returns the FIRST character of a string
// firstChar("Hello") → "H"
//
function firstChar(str) {
  return str[0];
}

console.log("\n6) firstChar():", firstChar("Hello"));


//
// 7. Convert this to an arrow function:
// function square(n) { return n * n; }
//
const square = (n) => n * n;

console.log("\n7) square():", square(6)); // Expect 36


//
// 8. Function that returns the longer of two strings
// longer("cat", "giraffe") → "giraffe"
//
function longer(a, b) {
    return a.length > b.length ? a : b; // explain: if a is longer than b, return a, else return b
}

console.log("\n8) longer():", longer("cat", "giraffe"));


//
// 9. Function that returns "even" or "odd"
// evenOrOdd(7) → "odd"
// evenOrOdd(12) → "even"
//
function evenOrOdd(n) {
  // your code
  return n % 2 === 0 ? "even" : "odd"; // explain: if n is divisible by 2, return "even", else return "odd"
}

console.log("\n9) evenOrOdd():", evenOrOdd(7), evenOrOdd(12));


//
// 10. CHALLENGE (soft intermediate)
//
// Create a function repeat(word, times)
// repeat("Hi", 3) → "HiHiHi"
//
function repeat(word, times) {
  // your code
}

console.log("\n10) repeat():", repeat("Hi", 3));



