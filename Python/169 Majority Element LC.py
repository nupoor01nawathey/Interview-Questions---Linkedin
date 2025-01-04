'''
169. Majority Element

Given an array nums of size n, return the majority element.

The majority element is the element that appears more than ⌊n / 2⌋ times.
You may assume that the majority element always exists in the array.

Example 1:

Input: nums = [3,2,3]
Output: 3
Example 2:

Input: nums = [2,2,1,1,1,2,2]
Output: 2
'''
def majority_element(nums):
  majority = nums[0]
  votes = 1
  for num in range(1, len(nums)):
    if votes == 0:
      votes += 1
      majority = nums[num]
    elif majority == nums[num]:
      votes += 1
    else:
      votes -= 1
  return majority
  
  
print(majority_element([2,2,1,1,1,2,2]))  # 2
print(majority_element([3,2,3]))          # 3
print(majority_element([1]))              # 1
print(majority_element([2,2]))            # 2
