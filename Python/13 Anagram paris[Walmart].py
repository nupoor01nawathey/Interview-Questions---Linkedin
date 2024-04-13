# Question:

# Given an array of strings strs, group the anagrams together. You can return the answer in any order.

# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

# Input: strs = ["eat","tea","tan","ate","nat","bat"]
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]] 


lst = ["eat","tea","tan","ate","nat","bat"]

def groupAnagrams(strs):
  dict={}
  for i in strs:
    new_value = ''.join(sorted(i)) # aet aet ant aet ant abt
    if new_value not in dict:
      dict[new_value] = [i]
      print(dict)
    else:
      dict[new_value].append(i)
  return list(dict.values())
  
  # {'aet': ['eat']}
  # {'aet': ['eat', 'tea'], 'ant': ['tan']}
  # {'aet': ['eat', 'tea', 'ate'], 'ant': ['tan', 'nat'], 'abt': ['bat']}

  
print(groupAnagrams(lst))
