# Write a function to find the longest common prefix string amongst an array of strings.

# If there is no common prefix, return an empty string "".

# Example 1:

# Input: strs = ["flower","flow","flight"]
# Output: "fl"
# Example 2:

# Input: strs = ["dog","racecar","car"]
# Output: ""
# Explanation: There is no common prefix among the input strings.



# 1. Get min common from list of strings first
# 2. Iterate over given list of strings and using find method check if prefix exisst or not
# 3. Whenever the prefix not found trim existing prefix by 1 char from the end  
def longestCommonPrefix(strs):
  prefix = min(strs, key=len) # flow
  for s in strs:
    while prefix and s.find(prefix) != 0:
      prefix = prefix[:-1]
      print("prefix in each iteration- ", prefix)
      print("find syntax output- ", s.find(prefix))
  return "Prefix- ",prefix

print(longestCommonPrefix(["flower","flow","flight"]))
print(longestCommonPrefix(["dog","racecar","car"]))

# print("flower".find("flow"))    # 0
# print("flow".find("flow"))      # 0
# print("flower".find("flight"))  # -1

