# You are given a dictionary with a key-value of {string: number} where values in the dictionary could be duplicates. 
# You are required to extract the unique values from the dictionary where the value occurred only once.

# Return a list of values where they occur only once.
# Note: You can return the values in any order.

# Input:
# dictionary = {"key1": 1, "key2": 1, "key3": 7, "key4": 3, "key5": 4, "key6": 7}
# Output:

# find_unique_values(dictionary) -> [3,4]
#Only 3 and 4 occurred once.

dictionary = {"key1": 1, "key2": 1, "key3": 7, "key4": 3, "key5": 4, "key6": 7}

c_hash = {}
for value in dictionary.values():
  if value in c_hash:
    c_hash[value] += 1
  else:
    c_hash[value] = 1

unique = []
for key, value in c_hash.items():
  if value == 1:
    unique.append(key)
  
print(c_hash)
print(unique)

# Output
# {1: 2, 7: 2, 3:1, 4:1}
# [3,4]
# Time Complexity : O(m) + O(n) due to 2 foreach loop



# One to many relation based on dictionary
# Find keys with duplicate values in dictionary in Python
dictA = {'Sun': 5, 'Mon': 3, 'Tue': 5, 'Wed': 3, 'Thur': 4}
updated_dictA = {}
for k, v in dictA.items():
  if v in updated_dictA:
    updated_dictA[v].append(k)
  else:
    updated_dictA[v] = [key]
  # updated_dictA.setdefault(v,[]).append(k) # Can use this instead of if .. else
print(updated_dictA)

# Output
# {5:['Sun','Tue'], 3: ['Mon','Wed'], 4: ['Thur']}

# Time Complexity : O(n)
# Space Complexity : 0(1) Constant space complexity

