# Finding all substrings from a given string
# It involves extracting every hashtag or possible contiguous sequence of characters within that string.

def find_substrings(lst):
  substrings = [] 
  n=len(lst)
  for i in range(n):
    # Inner loop for the ending index of substring
    for j in range(i + 1, n + 1):
      substring = lst[i:j]
      substrings.append(substring) 
  
  return substrings
  
input_str = "hello"
result = find_substrings(input_str)
print("All substrings of '{}' are:".format(input_str))
print(result)

['h', 'he', 'hel', 'hell', 'hello', 'e', 'el', 'ell', 'ello', 'l', 'll', 
'llo', 'l', 'lo', 'o']


