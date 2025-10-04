#!/bin/bash
# Bash Shell Script
# Language ID: 106

echo "Hello from Bash!"
echo "Shell: $SHELL"
echo "Current directory: $(pwd)"

# Variables
NAME="Judge0"
VERSION="Custom"

echo "Running $NAME $VERSION"

# Array operations
declare -a numbers=(1 2 3 4 5)
echo "Numbers: ${numbers[@]}"

# Loop example
echo "Counting to 5:"
for i in {1..5}; do
    echo "  $i"
done

# Function example
greet() {
    local name=$1
    echo "Hello, $name!"
}

greet "World"
greet "Game Developer"
