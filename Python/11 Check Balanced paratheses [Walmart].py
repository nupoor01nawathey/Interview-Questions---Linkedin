# Walmart, Given an expression string, write a python program to find whether a given string has balanced parentheses or not.

# Examples:

# Input : {[]{()}}
# Output : Balanced

# Input : [{}{}(]
# Output : Unbalanced


# Create a Map {'(': ')', '{': '}', '[': ']'}
# Iterate over each char in the input_str match that with open_tup if exists then push corresponding closing bracket type in a queue/stack
# if don't exist then check in close_tup and if found check if exists in queue/stack and decide whether Balanced or Un-balanced
def check(input_string):
  open_tup = tuple('({[')
  close_tup = tuple(')}]')
  map = dict(zip(open_tup, close_tup))
  print(map)

  queue = []
  for i in input_string:
    if i in open_tup:
      queue.append(map[i])
      print(queue)
    elif i in close_tup:
      if i not in queue or i != queue.pop():
        return 'Un-balanced'
        
  if not queue:
    return 'Balanced'
  else:
    return 'Un-balanced'

# Driver code
string = "{[]{()}}" # balanced
print(string,"-", check(string))
 
string = "[{}{})(]" # unbalanced
print(string,"-", check(string))

string = "((()"   # unbalanced
print(string,"-",check(string))

