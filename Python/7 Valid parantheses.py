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
  close_to_open_map={
    ")": "(",
    "}": "{",
    "]": "[",
  }
  stack=[]
  for char in s:
    if char in close_to_open_map:
      if stack:
        top_element = stack.pop() 
      if close_to_open_map[char] != top_element:
        return False
    else:
      stack.append(char)
  return not stack

print(is_valid_parantheses("()"))
print(is_valid_parantheses("()[]{}"))
print(is_valid_parantheses("(]"))
print(is_valid_parantheses("({})[]"))

