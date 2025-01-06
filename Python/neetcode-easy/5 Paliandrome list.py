#
# Approach:
# Define Left index=0 and right index=len(lst)-1
# Make sure l and r don't collide and check if left index matches with right
# If not means not paliandrome
# Increment l and decrement r
#

def is_paliandrome(lst):
    nums = []

    l, r = 0, len(lst)-1
    while l <= r:
        if lst[l] != lst[r]:
            return False
        l = l+1
        r = r-1
    return True
        

print(is_paliandrome('racecar'))
print(is_paliandrome('cat'))
print(is_paliandrome('naman'))

# 
# Searching a Key in Dictionary takes O(1) time
# Expected  Time complexity O(N) -> Converting singly linked list to Array
# Space complexity 0(N) -> Need extra space while converting linked list to array
#

'''
125. A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.
Given a string s, return true if it is a palindrome, or false otherwise.


Example 1:
Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.

Example 2:
Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.

Example 3:
Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.
'''
def is_paliandrome(s):
  l, r = 0, len(s)-1
  
  while l < r:
    while l < r and not is_alphanumeric(s[l]):
      l+=1
    while r > l and not is_alphanumeric(s[r]):
      r-=1
    if s[l].lower() != s[r].lower():
      return False
    l, r = l+1, r-1
  return True
    


def is_alphanumeric(c):
  return (
      ord('A') <= ord(c) <= ord('Z') or 
      ord('0') <= ord(c) <= ord('9') or
      ord('a') <= ord(c) <= ord('z')
  )
  
print(is_paliandrome("A man, a plan, a canal: Panama"))
print(is_paliandrome("race a car"))
print(is_paliandrome(" "))



