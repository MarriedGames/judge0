// TypeScript Hello World
// Language ID: 102

interface Person {
    name: string;
    age: number;
}

const greet = (person: Person): string => {
    return `Hello, ${person.name}! You are ${person.age} years old.`;
};

const user: Person = {
    name: "John",
    age: 30
};

console.log(greet(user));

// Type safety example
const numbers: number[] = [1, 2, 3, 4, 5];
const sum: number = numbers.reduce((acc, n) => acc + n, 0);
console.log("Sum:", sum);
