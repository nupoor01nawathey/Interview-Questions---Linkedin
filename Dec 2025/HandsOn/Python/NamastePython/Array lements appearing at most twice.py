"""
172 - Array Duplicates

Your task is to return an array of all the integers that appear twice in the given array.
You may return the output in any order ,  the driver code will handle sorting before printing.

Example 1
Input:
[2, 3, 1, 2, 3]
Output:
[2, 3]
Explanation:
2 and 3 occur more than once in the given array.

Example 2
Input:
[3, 1, 2]
Output:
[]
Explanation:
There is no repeating element in the array, so the output is empty.

Constraints
1 ≤ n ≤ 10^6
1 ≤ arr[i] ≤ n
"""

def find_duplicates(arr: list[int]) -> list[int]:
	hash_map = {}
	res = []
	for el in arr:
		hash_map[el] = hash_map.get(el, 0) + 1
		if hash_map[el] == 2:
			res.append(el)
	return(res)

	# dups = set()
	# n = []
	# for i in arr:
	# 	if i not in dups:
	# 		dups.add(i)
	# 	elif i not in n:
	# 		n.append(i)		
	# return n

print(find_duplicates([2, 3, 1, 2, 3]))
print(find_duplicates([3, 1, 2]))
print(find_duplicates([5, 5, 5, 1, 2, 3]))
print(find_duplicates([3, 1, 1]))
print(find_duplicates([9, 8, 7, 8, 6, 9, 5, 9]))
