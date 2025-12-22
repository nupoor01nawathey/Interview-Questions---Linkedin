"""
You are given a list of positive integers arr where all numbers occur an even number of times except one, which occurs an odd number of times.
Write a Python function to find and return that number.
 
Example 1
Input:
arr = [1, 2, 3, 2, 3, 1, 3]
Output:
3
Explanation:
All numbers occur twice except 3, which occurs three times (odd).

Example 2
Input:
arr = [5, 7, 2, 7, 5, 2, 5]
Output:
5
Explanation:
All numbers occur twice except 5, which occurs three times (odd).

Constraints
1 <= len(arr) <= 10^6
1 <= arr[i] <= 10^9
Exactly one element occurs an odd number of times.
"""

def find_odd_occurrence(arr: list[int]) -> int:
	hash_map = {}
	for num in arr:
		hash_map[num] = hash_map.get(num, 0) + 1
	
	for k, v in hash_map.items():
		if v % 2 == 1:
			return(k)

print(find_odd_occurrence([1, 2, 3, 2, 3, 1, 3])) # 3
print(find_odd_occurrence([5, 7, 2, 7, 5, 2, 5])) # 5
print(find_odd_occurrence([9]))  # 9
print(find_odd_occurrence([6, 6, 6, 6, 6, 6, 7])) # 7
print(find_odd_occurrence([99, 1, 1, 2, 2, 3, 3])) # 99
