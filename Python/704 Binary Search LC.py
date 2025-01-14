'''
Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. 
If target exists, then return its index. Otherwise, return -1.

You must write an algorithm with O(log n) runtime complexity.

Example 1:
Input: nums = [-1,0,3,5,9,12], target = 9
Output: 4
Explanation: 9 exists in nums and its index is 4

Example 2:
Input: nums = [-1,0,3,5,9,12], target = 2
Output: -1
Explanation: 2 does not exist in nums so return -1
'''

# Time complexity : O(log N)

def binary_search(n, target):
  l, r = 0, len(n)-1
  
  while l <= r:
    mid = (l + r) // 2
    if target > n[mid]:
      l = mid + 1
    elif target < n[mid]:
      r = mid - 1
    else:
      return True
  return False
  
print(binary_search([-1,0,3,5,9,12], 9))   # True
print(binary_search([-1,0,3,5,9,12], 2))   # False
