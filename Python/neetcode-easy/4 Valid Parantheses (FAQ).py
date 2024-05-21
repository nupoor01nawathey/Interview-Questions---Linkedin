#
# Approach:
# Create close to open hash map with Key=closing bracket and Value=opening bracket
# Iterate over list and check stack if exists, ideally stack shohuld have open paratheses
# Check last value in stack it should match with close_to_open_hash_map's value
# If match is found remove using pop()
# If c not found in stack then append


def valid_parantheses(s):
    stack=[]
    close_to_open_map = {")": "(", "]": "[", "}": "{"}

    if len(s) % 2 != 0:
        return False
    
    for c in s:
        if c in close_to_open_map:
            if stack and stack[-1] == close_to_open_map[c]:
                stack.pop()
            else:
                return False
        else:
            stack.append(c) 

    return True if not stack else False

print(valid_parantheses("()"))
print(valid_parantheses('({[]})'))
print(valid_parantheses('(}]['))
print(valid_parantheses("[{}{})(]"))

# 
# Searching a Key in Dictionary takes O(1) time
# Time complexity O(N) -> Iterating over list
# Space complexity 0(N) -> Stack and Extra space for Hash Map
#

