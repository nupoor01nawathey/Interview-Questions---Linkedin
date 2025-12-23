"""
You are given an array arr of size n − 1 that contains distinct integers in the range 1 to n (inclusive).
This array represents a permutation of numbers from 1 to n, but one number is missing.

Your task is to identify and return the missing number. All numbers are distinct, exactly one number is missing.

Example 1
Input
[1, 2, 3, 5]
Output
4
Explanation:
Numbers from 1 to 5 should be 1, 2, 3, 4, 5.
Only 4 is missing.

Example 2
Input
[8, 2, 4, 5, 3, 7, 1]
Output
6
Explanation:
Numbers from 1 to 8 should be 1–8.
Only 6 is missing.

Example 3
Input
[1]
Output
2
Explanation:
Array has only 1, so missing number is 2.

Constraints
1 ≤ arr.size() ≤ 1,000,000
1 ≤ arr[i] ≤ arr.size() + 1
"""


def find_missing_number(arr: list[int]) -> int:
	max_el = max(arr)
	for i in range(1, max_el+2):
		if i not in arr:
			return i

print(find_missing_number([1, 2, 3, 5])) # 4
print(find_missing_number([8, 2, 4, 5, 3, 7, 1])) # 6
print(find_missing_number([1])) # 2
print(find_missing_number([2])) # 1
print(find_missing_number([2, 3, 4, 5, 6, 7, 8, 9, 10])) # 1