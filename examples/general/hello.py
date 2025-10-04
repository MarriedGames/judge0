# Python Hello World
# Language ID: 105

import sys
import json
from datetime import datetime

def main():
    print("Hello from Python 3.11!")
    print(f"Python version: {sys.version}")
    
    # Data structures
    data = {
        "message": "Hello, World!",
        "timestamp": datetime.now().isoformat(),
        "numbers": list(range(1, 11))
    }
    
    print("\nJSON output:")
    print(json.dumps(data, indent=2))
    
    # List comprehension
    squares = [x**2 for x in range(1, 6)]
    print(f"\nSquares: {squares}")
    
    # Function example
    def fibonacci(n):
        if n <= 1:
            return n
        return fibonacci(n-1) + fibonacci(n-2)
    
    print(f"\nFibonacci(10) = {fibonacci(10)}")

if __name__ == "__main__":
    main()
