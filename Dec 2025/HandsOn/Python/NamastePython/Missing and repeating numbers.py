"""
You are given an unsorted array arr[] of size n, containing integers in the range 1 to n.
It is known that exactly one number is missing and one number appears twice.

Your task is to find both —
1- The repeating number
2- The missing number
Return them as a list [repeating, missing].

Example 1
Input: arr = [2, 2]
Output: [2, 1]
Explanation: Repeating number is 2 and the missing number is 1. 

Example 2
Input: arr = [1, 3, 3]
Output: [3, 2]
Explanation: Repeating number is 3 and the missing number is 2. 

Example 3
Input: arr = [4, 3, 6, 2, 1, 1]
Output: [1, 5]
Explanation: Repeating number is 1 and the missing number is 5. 

Constraints
2 ≤ arr.size() ≤ 10^6  
1 ≤ arr[i] ≤ n
"""

def find_missing_and_repeating(arr):
    repeat, missing = 0, 0
    for i in range(1, len(arr)+1):
        if arr.count(i) == 0:
            missing = i
        elif arr.count(i) == 2:
            repeat = i
    return([repeat, missing])


print(find_missing_and_repeating([2, 2]))       # [2, 1]
print(find_missing_and_repeating([1, 3, 3]))    #[3, 2]
print(find_missing_and_repeating([4, 3, 6, 2, 1, 1])) # [1, 5]
print(find_missing_and_repeating([1, 1]))       # [1, 2]
