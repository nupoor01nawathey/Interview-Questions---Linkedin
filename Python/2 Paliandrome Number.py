# Given an integer x, return true if x is a palindrome and false otherwise.

# Example 1:
# Input: x = 121
# Output: true
# Explanation: 121 reads as 121 from left to right and from right to left.
# Example 2:

# Input: x = -121
# Output: false
# Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
# Example 3:

# Input: x = 10
# Output: false
# Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
 
# Constraints:
# -231 <= x <= 231 - 1

def is_paliandrome_number(num):
  rev=0
  temp=num
  while(num>0):
    digit=num%10
    rev=rev*10+digit
    num=num//10
  if(temp==rev):
    return True
  else:
    return False
    
print(is_paliandrome_number(121))  # True
print(is_paliandrome_number(10))   # False
print(is_paliandrome_number(-121)) # False


# Paliandorme check for string
def paliandrome_string(s):
  s=s.lower()
  i=0
  j=len(s)-1
  while(i<=j):
    if s[i]==s[j]:
      i+=1
      j-=1
    else:
      return False
  return True

print(paliandrome_string("NiTin")) # True
print(paliandrome_string("Ratul")) # False


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

