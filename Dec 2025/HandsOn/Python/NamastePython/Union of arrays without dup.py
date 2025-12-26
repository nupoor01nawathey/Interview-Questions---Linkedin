"""
Union of Two Arrays

You are given two arrays a[] and b[].
Your task is to return the Union of both arrays — i.e., all distinct elements that appear in either array.

If an element appears more than once in one or both arrays, it should be included only once in the result.

Note:
1- The elements of a[] and b[] are not necessarily distinct.
2- You can return the union in any order, but the driver code will print the result in sorted order.

Example 1
Input: a[] = [1, 2, 3, 2, 1], b[] = [3, 2, 2, 3, 3, 2]
Output: [1, 2, 3]
Explanation:
The union of both arrays includes all unique elements: 1, 2, and 3.

Example 2
Input: a[] = [1, 2, 3], b[] = [4, 5, 6]
Output: [1, 2, 3, 4, 5, 6]
Explanation:
All elements from both arrays are distinct, so the union contains all of them.

Example 3
Input: a[] = [1, 2, 1, 1, 2], b[] = [2, 2, 1, 2, 1]
Output: [1, 2]
Explanation:
The union includes only the distinct elements: 1 and 2.

Constraints
1 ≤ a.size(), b.size() ≤ 10^6 
0 ≤ a[i], b[i] ≤ 10^5
"""

def find_union(a: list[int], b: list[int]) -> list[int]:
	res = set()
	for num in a+b:
		res.add(num)
	return(list(res))
		

print(find_union([1, 2, 3, 2, 1], [3, 2, 2, 3, 3, 2]))  # [1, 2, 3]
print(find_union([1, 2, 3], [4, 5, 6]))                 # [1, 2, 3, 4, 5, 6]
print(find_union([1, 2, 1, 1, 2], [2, 2, 1, 2, 1]))     # [1, 2]
print(find_union([], [5, 5, 5]))        # [5]
print(find_union([1, 1, 1], [1, 1]))    # [1]
print(find_union([1, 2, 3], [3, 2, 1])) # [1, 2, 3]
print(find_union([10, 20, 30], []))     # [10, 20, 30]
