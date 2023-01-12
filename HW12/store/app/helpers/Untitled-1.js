// function logPerson() {
//   console.log(`Person: ${this.name}, ${this.age}`)
// }

// const person1 = { name: 'Alex', age: 38 };

// function bind(context, fn) {
//   return function (...args) {
//     fn.call(context, args)
//   }
// }


// bind(person1, logPerson)()


// const setData = (address) => { 
//   const personAddress = `adress: ${address}`;

//   return (name) => {
//     console.log(`person: ${name}, ${personAddress}`);
//   }
// }

// const setPersone = setData('Kyiv');

// setPersone;
// console.log(a)
// let a = 2

// Function.prototype.myBind = function(context, ...args) {
//   return (...rest) => this.call(context, ...args.concat(rest))
// }

// function test (...args) {
//   console.log(this.name, ...args)
// }

// person = {
//   name: 'Elena'
// }

// test.myBind(person, 33)(234, 123)
















// Function.prototype.newBind = function(context, ...args) {
//   return (...rest) => this.call(context, ...args.concat(rest))
// }


// const person = {
//   name: 'Elena'
// }

// const person2 = {
//   name: 'Alex'
// }


// function test(...args) {
//   console.log(this.name, ...args)
// }


// test.newBind(person, 123)(123, 4321)

// test.newBind(person2, 122)(222, 333)


const person = {
  name: 'Elena',
  age: 21,
  personData() {
    console.log(`${this.name}`)
    console.log(`${this.age}`)
  }
}

const person2 = {
  name: 'Alex',
  age: 123
}


person.personData.bind(person2)()