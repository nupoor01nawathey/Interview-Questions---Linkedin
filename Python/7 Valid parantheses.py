# Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

# An input string is valid if:

# Open brackets must be closed by the same type of brackets.
# Open brackets must be closed in the correct order.
# Every close bracket has a corresponding open bracket of the same type.
 
# Example 1:

# Input: s = "()"
# Output: true
# Example 2:

# Input: s = "()[]{}"
# Output: true
# Example 3:

# Input: s = "(]"
# Output: false

def is_valid_parantheses(s):
  close_to_open_mapping = {
    "}": "{" ,
    ")": "(" ,
    "]": "["
  }
  stack = []

 # Store all opening brackets in stack
 # Keep all closing to opening brackets mapping in a hashmap
 # Iterate over the string of brackets, check if stack[-1] is available in mapping[c], if found remove
 # In the end check empty stack
 
  for char in s:
    if char in close_to_open_mapping:
      if stack and stack[-1] == close_to_open_mapping[char]:
        stack.pop()
      else:
        return False
    else:
      stack.append(char)
  return True if not stack else False


print(is_valid_parantheses("()"))
print(is_valid_parantheses("()[]{}"))
print(is_valid_parantheses("(]"))
print(is_valid_parantheses("({})[]"))

