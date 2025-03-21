We often found Recursion difficult to understand and implement. In this article, we will try to understand fundamentals of recursion and how could we implement it in real life. Let's start.

We know about function. It's a block of code to perform a specific task. Consider the following:



```python
# --- Example 1 ---
# Function to add two numbers
def add(a, b):
    """
    add takes two numbers as inputs and returns their sum
    """
    res = a + b
    return res
    
# We can call the function as like:
a, b = 15, 20
print(add(a, b))

# --- Example 2 ---
# Function to print Hello World!
def print_hello():
    """
    print_hello prints Hello World!
    """
    print("Hello World!")

# Call the function
print_hello()

```

    35
    Hello World!


We can create a function for a specific task and call it to perform that.<br>
__Think: what will happen if the function call itself inside it?__ Consider the following:

<code>
def print_hello():
    """
    print_hello prints Hello World!
    """
    print("Hello World!")
    print_hello()

\# Call the function
print_hello()
</code>

Look carefully! When we run print_hello function, it will start calling itself again and again. That will create an infinite loop. So we need to add a condition to limit it. i.e., if we want to print it ten times, we can modify the code as following.



```python
def print_hello(n):
    """
    print_hello prints "Hello World!" n times using recursion.
    """
    if n == 0:  # Base Condition
        print("Recursion Finished!")
        return  # Stop recursion

    print("Hello World!")
    print_hello(n - 1)  # Recursive call with reduced n

# Call the function
n = 10
print_hello(n)

```

    Hello World!
    Hello World!
    Hello World!
    Hello World!
    Hello World!
    Hello World!
    Hello World!
    Hello World!
    Hello World!
    Hello World!
    Recursion Finished!


We call this the base condition. Every recursive function must have a base condition at the beginning to determine when the recursion should stop. It acts as a stopping criterion that prevents infinite recursion and ensures the function eventually returns a result.    
Recursion is a powerful technique used when a problem can be broken down into smaller, repetitive subproblems. If we notice that a certain task involves repeating the same process on smaller portions of data, we can apply recursion to solve it efficiently.  
Let's explore this concept with some examples.  

### Factorial

__Formula:__ $n! = n * (n-1) * (n-2) * ... * 1$<br>
$\implies n! = n * (n-1)!$<br>
$\implies n! = n * (n-1) * (n-2)!$<br>
$\implies n! = n * (n-1) * (n-2) * (n-3)!$<br>

Do you see any pattern in this? It repeteadly multiplies $n$ with $(n-1)!$.

__Implementation:__
If we want to implement it, we need to think about the recursive formula and the base condition at first. The formula is given above. Now, proceed to define base condition.  
We know factorial is not possible for negative numbers and $0! = 1$ and $1! = 1$.  

We need to calculate factorial(n). Let's define the function step by step.  

__Step 1: Define the Recursive Formula (Recursive Case)__  

```python
def factorial(n):
    return n * factorial(n - 1)  # recursive formula
```

__Step 2: Add the Base Condition (Stopping Condition)__  

```python
def factorial(n):
    if n in [0, 1]:  # base condition
        return 1
    return n * factorial(n - 1)  # recursive formula
```



```python
# Function to implement factorial
def factorial(n):
    """
    Calculate factorial recursively.
    """
    if n < 0:
        return 0
    elif n in [0, 1]:
        return 1
    return n * factorial(n - 1)

# Call the function
n = 5
print(factorial(n))

```

    120


### Now, let's focus on how it works!

##### **1<sup>st</sup> Iteration:**  
When calling `factorial(5)`, the function checks the base condition. Since `n = 5` does not satisfy the base condition, it moves to the next step.  
It encounters `n * factorial(n - 1)`, so a **new frame** is pushed onto the stack, containing the function name, argument `n = 5`, and the return address. The function then calls itself recursively with `n = 4`.  

The **call stack** follows the **Last In, First Out (LIFO)** rule.  

##### **2<sup>nd</sup> Iteration:**  
The function checks the base condition again. Since `n = 4` does not satisfy it, a **new frame** is pushed onto the stack with `n = 4`, and the function calls itself recursively with `n = 3`.  

##### **3<sup>rd</sup> Iteration:**  
The function checks the base condition again. Since `n = 3` does not satisfy it, a **new frame** is pushed onto the stack with `n = 3`, and the function calls itself recursively with `n = 2`.  

##### **4<sup>th</sup> Iteration:**  
The function checks the base condition again. Since `n = 2` does not satisfy it, a **new frame** is pushed onto the stack with `n = 2`, and the function calls itself recursively with `n = 1`.  

##### **5<sup>th</sup> Iteration (Base Case Reached):**  
The function checks the base condition, and since `n = 1` satisfies it, it returns `1`. The topmost frame is **popped** from the stack, and control returns to the previous function frame (`n = 2`).  

---

##### **Stack Unwinding (Returning Values):**  
Now, the stored frames start returning and multiplying in reverse order:  

$$
factorial(1) = 1
\to
factorial(2) = 2 \times factorial(1) = 2 \times 1 = 2
\to
factorial(3) = 3 \times factorial(2) = 3 \times 2 = 6
\to
$$
$$
factorial(4) = 4 \times factorial(3) = 4 \times 6 = 24
\to
factorial(5) = 5 \times factorial(4) = 5 \times 24 = 120
$$

i.e., $$
1 (base\ case) \to 2 \times 1 \to 3 \times 2 \to 4 \times 6 \to 5 \times 24 \to 120
$$

Each time a function returns, its **frame is popped from the stack**, and execution resumes in the previous frame.  

Thus, the final output is **120**.  

Look at the output of the below code to know it better:



```python
import sys

def factorial(n, iteration=0):
    """
    Calculates the factorial of n while visualizing the recursion stack.
    """
    frame = sys._getframe()
    indent = "  " * iteration  # Indentation for better readability

    print(f"{indent}📌 [Iteration {iteration}] Pushing to Stack -> (Function name: {frame.f_code.co_name}, "
          f"Argument: n={n}, Return Address: {id(frame)})")

    if n < 0:
        print(f"\n{indent}🔄 [Iteration {iteration}] Base Case Reached (Negative) -> Returning 0 to Address: {id(frame.f_back)}\n")
        return 0  # Negative factorial is undefined
    elif n in [0, 1]:  # Base case
        print(f"\n{indent}🔄 [Iteration {iteration}] Base Case Reached -> Returning 1 to Address: {id(frame.f_back)}\n")
        return 1

    # Recursive call
    result = n * factorial(n - 1, iteration + 1)

    print(f"{indent}🔙 [Iteration {iteration}] Returning {result} to Address: {id(frame.f_back)} (Caller Function)")

    return result  # Returning computed factorial

# Call the function
n = 5
print(f"\nFactorial({n}) = {factorial(n)}")

```

    📌 [Iteration 0] Pushing to Stack -> (Function name: factorial, Argument: n=5, Return Address: 132069547997600)
      📌 [Iteration 1] Pushing to Stack -> (Function name: factorial, Argument: n=4, Return Address: 132069547997312)
        📌 [Iteration 2] Pushing to Stack -> (Function name: factorial, Argument: n=3, Return Address: 132069547997888)
          📌 [Iteration 3] Pushing to Stack -> (Function name: factorial, Argument: n=2, Return Address: 132069547998176)
            📌 [Iteration 4] Pushing to Stack -> (Function name: factorial, Argument: n=1, Return Address: 132069547998464)
    
            🔄 [Iteration 4] Base Case Reached -> Returning 1 to Address: 132069547998176
    
          🔙 [Iteration 3] Returning 2 to Address: 132069547997888 (Caller Function)
        🔙 [Iteration 2] Returning 6 to Address: 132069547997312 (Caller Function)
      🔙 [Iteration 1] Returning 24 to Address: 132069547997600 (Caller Function)
    🔙 [Iteration 0] Returning 120 to Address: 132069548291344 (Caller Function)
    
    Factorial(5) = 120


In each iteration, a frame is pushed into stack. This frame contains the following:
- The function name
- Agrument
- Return address

Look carefully at addresses while pushing and stack unwinding.



```python

```

## Fibonacci Sequence

__Formula:__  
The Fibonacci sequence is defined by the recursive formula:
- $F(0) = 0$
- $F(1) = 1$
- $F(n) = F(n-1) + F(n-2), \ where \ n > 1$

This means that each Fibonacci number is the sum of the two preceding numbers.

__Implementation:__  
We can implement this using a recursive approach based on the formula and the base conditions.

__Step 1: Define the Recursive Formula (Recursive Case)__  
We know that the Fibonacci number at position $n$ is the sum of the Fibonacci numbers at positions $n-1$ and $n-2$.

```python
def fibonacci(n):
    return fibonacci(n - 1) + fibonacci(n - 2)  # recursive formula
```

__Step 2: Add the Base Condition (Stopping Condition)__  
The Fibonacci sequence has base cases:
- $F(0) = 0$
- $F(1) = 1$

So, we add these conditions to stop the recursion.

```python
def fibonacci(n):
    if n == 0:  # base condition
        return 0
    if n == 1:  # base condition
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)  # recursive formula
```



```python
# Function to calculate nth Fibonacci number
def fibonacci(n):
    """
    It calculates n-th fibonacci number
    """
    if n <= 0:  # base condition
        return 0
    elif n == 1:  # base condition
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)  # recursive formula

# Call the function
n = 5
print(fibonacci(n))

```

    5


### **Now, let's focus on how the Fibonacci recursive function works!**

##### **1<sup>st</sup> Iteration:**  
When calling `fibonacci(5)`, the function checks the base condition. Since `n = 5` does not satisfy it, a **new frame** is pushed onto the stack, containing the function name, argument `n = 5`, and the return address.  
The function then makes two recursive calls:  
$$
fibonacci(5) = fibonacci(4) + fibonacci(3)
$$

##### **2<sup>nd</sup> Iteration (fibonacci(4)):**  
The function checks the base condition again. Since `n = 4` does not satisfy it, a **new frame** is pushed onto the stack with `n = 4`, and the function calls:  

$$
fibonacci(4) = fibonacci(3) + fibonacci(2)
$$

##### **3<sup>rd</sup> Iteration (fibonacci(3)):**  
Again, since `n = 3` does not satisfy the base case, a **new frame** is pushed onto the stack with `n = 3`, and the function calls:  

$$
fibonacci(3) = fibonacci(2) + fibonacci(1)
$$

##### **4<sup>th</sup> Iteration (fibonacci(2)):**  
Since `n = 2` does not satisfy the base case, a **new frame** is pushed onto the stack with `n = 2`, and the function calls:  

$$
fibonacci(2) = fibonacci(1) + fibonacci(0)
$$

##### **5<sup>th</sup> Iteration (Base Case Reached):**  
The function reaches the base cases:  
- `fibonacci(1) = 1`  
- `fibonacci(0) = 0`  

These values are returned, and the topmost frames are **popped** from the stack.

---

#### **Stack Unwinding (Returning Values):**  
Now, the stored frames start returning values in reverse order:  

$$
fibonacci(2) = fibonacci(1) + fibonacci(0) = 1 + 0 = 1
$$

$$
fibonacci(3) = fibonacci(2) + fibonacci(1) = 1 + 1 = 2
$$

$$
fibonacci(4) = fibonacci(3) + fibonacci(2) = 2 + 1 = 3
$$

$$
fibonacci(5) = fibonacci(4) + fibonacci(3) = 3 + 2 = 5
$$

Each time a function returns, its **frame is popped from the stack**, and execution resumes in the previous frame.  

Thus, the final output is **5**.  



```python
def fibonacci(n, iteration=0):
    """Calculates the n-th Fibonacci number while visualizing the recursion stack."""
    frame = sys._getframe()
    indent = "  " * iteration  # Indentation for readability

    print(f"{indent}📌 [Iteration {iteration}] Pushing to Stack -> Function: {frame.f_code.co_name}, "
          f"Address: {id(frame)}, Argument: n={n}")

    if n <= 0:
        print(f"\n{indent}🔄 [Iteration {iteration}] Base Case Reached -> Returning 0 to Address: {id(frame.f_back)}\n")
        return 0  # Base case: fibonacci(0) = 0
    elif n == 1:
        print(f"\n{indent}🔄 [Iteration {iteration}] Base Case Reached -> Returning 1 to Address: {id(frame.f_back)}\n")
        return 1  # Base case: fibonacci(1) = 1

    # Recursive calls
    left = fibonacci(n - 1, iteration + 1)
    right = fibonacci(n - 2, iteration + 1)
    result = left + right  # Summing results

    print(f"{indent}🔙 [Iteration {iteration}] Returning {result} to Address: {id(frame.f_back)} (Caller Function)")

    return result  # Returning the computed Fibonacci number

# Call the function
n = 5
print(f"\nFibonacci({n}) = {fibonacci(n)}")

```

    📌 [Iteration 0] Pushing to Stack -> Function: fibonacci, Address: 132069547997312, Argument: n=5
      📌 [Iteration 1] Pushing to Stack -> Function: fibonacci, Address: 132069547997600, Argument: n=4
        📌 [Iteration 2] Pushing to Stack -> Function: fibonacci, Address: 132069547997888, Argument: n=3
          📌 [Iteration 3] Pushing to Stack -> Function: fibonacci, Address: 132069547998176, Argument: n=2
            📌 [Iteration 4] Pushing to Stack -> Function: fibonacci, Address: 132069547998464, Argument: n=1
    
            🔄 [Iteration 4] Base Case Reached -> Returning 1 to Address: 132069547998176
    
            📌 [Iteration 4] Pushing to Stack -> Function: fibonacci, Address: 132069547998752, Argument: n=0
    
            🔄 [Iteration 4] Base Case Reached -> Returning 0 to Address: 132069547998176
    
          🔙 [Iteration 3] Returning 1 to Address: 132069547997888 (Caller Function)
          📌 [Iteration 3] Pushing to Stack -> Function: fibonacci, Address: 132069548310880, Argument: n=1
    
          🔄 [Iteration 3] Base Case Reached -> Returning 1 to Address: 132069547997888
    
        🔙 [Iteration 2] Returning 2 to Address: 132069547997600 (Caller Function)
        📌 [Iteration 2] Pushing to Stack -> Function: fibonacci, Address: 132069548310592, Argument: n=2
          📌 [Iteration 3] Pushing to Stack -> Function: fibonacci, Address: 132069548311168, Argument: n=1
    
          🔄 [Iteration 3] Base Case Reached -> Returning 1 to Address: 132069548310592
    
          📌 [Iteration 3] Pushing to Stack -> Function: fibonacci, Address: 132069548311456, Argument: n=0
    
          🔄 [Iteration 3] Base Case Reached -> Returning 0 to Address: 132069548310592
    
        🔙 [Iteration 2] Returning 1 to Address: 132069547997600 (Caller Function)
      🔙 [Iteration 1] Returning 3 to Address: 132069547997312 (Caller Function)
      📌 [Iteration 1] Pushing to Stack -> Function: fibonacci, Address: 132069548311744, Argument: n=3
        📌 [Iteration 2] Pushing to Stack -> Function: fibonacci, Address: 132069548312032, Argument: n=2
          📌 [Iteration 3] Pushing to Stack -> Function: fibonacci, Address: 132069548312320, Argument: n=1
    
          🔄 [Iteration 3] Base Case Reached -> Returning 1 to Address: 132069548312032
    
          📌 [Iteration 3] Pushing to Stack -> Function: fibonacci, Address: 132069548312608, Argument: n=0
    
          🔄 [Iteration 3] Base Case Reached -> Returning 0 to Address: 132069548312032
    
        🔙 [Iteration 2] Returning 1 to Address: 132069548311744 (Caller Function)
        📌 [Iteration 2] Pushing to Stack -> Function: fibonacci, Address: 132069548312896, Argument: n=1
    
        🔄 [Iteration 2] Base Case Reached -> Returning 1 to Address: 132069548311744
    
      🔙 [Iteration 1] Returning 2 to Address: 132069547997312 (Caller Function)
    🔙 [Iteration 0] Returning 5 to Address: 132069548292800 (Caller Function)
    
    Fibonacci(5) = 5



```python

```
