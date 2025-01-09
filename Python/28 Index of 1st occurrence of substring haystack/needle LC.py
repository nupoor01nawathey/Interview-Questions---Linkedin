'''
Given two strings needle and haystack, return the index of the 
first occurrence of needle in haystack, or -1 if needle is not part of haystack.

Example 1:
Input: haystack = "sadbutsad", needle = "sad"
Output: 0
Explanation: "sad" occurs at index 0 and 6.
The first occurrence is at index 0, so we return 0.

Example 2:
Input: haystack = "leetcode", needle = "leeto"
Output: -1
Explanation: "leeto" did not occur in "leetcode", so we return -1.
'''


def find_needle_in_haystack(haystack, needle):
  left, right = 0, len(needle)-1
  
  while right < len(haystack)-1:
    if haystack[left:right+1] == needle:
      return left
    left += 1
    right += 1
    
  return -1
  
print(find_needle_in_haystack("hello", "ll"))    
print(find_needle_in_haystack("sadbutsad", "sad"))    
print(find_needle_in_haystack("leetcode", "leeto"))     


