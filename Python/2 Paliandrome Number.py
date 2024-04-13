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


