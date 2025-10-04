-- Lua Hello World
-- Language ID: 107

print("Hello from Lua 5.4!")
print("Lua version: " .. _VERSION)

-- Table (similar to arrays/objects)
local person = {
    name = "John",
    age = 30,
    skills = {"Lua", "Game Development", "Scripting"}
}

print("\nPerson info:")
print("Name: " .. person.name)
print("Age: " .. person.age)

print("\nSkills:")
for i, skill in ipairs(person.skills) do
    print("  " .. i .. ". " .. skill)
end

-- Function example
function factorial(n)
    if n <= 1 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

print("\nFactorial(5) = " .. factorial(5))

-- Table operations
local numbers = {1, 2, 3, 4, 5}
local sum = 0
for _, num in ipairs(numbers) do
    sum = sum + num
end

print("Sum of numbers: " .. sum)
