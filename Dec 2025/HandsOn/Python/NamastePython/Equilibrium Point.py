"""
You are given an array of integers arr[]. Your task is to find the first equilibrium index in the array.
An equilibrium point is an index (0-based indexing) such that the sum of all elements before it is equal to the sum of all elements after it.
If no such index exists, return -1.

Example 1
Input: arr = [1, 2, 0, 3]
Output: 2
Explanation: Left sum = 1 + 2 = 3, Right sum = 3 → Equal, equilibrium index is 2.

Example 2
Input: arr = [1, 1, 1, 1]
Output: -1
Explanation: No index exists where left and right sums are equal.

Example 3
Input: arr = [-7, 1, 5, 2, -4, 3, 0]
Output: 3
Explanation: Left sum = -7 + 1 + 5 = -1, Right sum = -4 + 3 + 0 = -1 → Equal, equilibrium index is 3. 

Constraints
3 <= arr.size() <= 10^5
-10^4 <= arr[i] <= 10^4
"""

def equilibrium_point(lst):
    total_sum = sum(lst)
    left_sum = 0
    for i in range(len(lst)):
        right_sum = total_sum - left_sum - lst[i]
        if left_sum == right_sum:
            return(i)
        else:
            left_sum += lst[i]
    return(-1)

print(equilibrium_point([1, 2, 0, 3]))
print(equilibrium_point([1, 1, 1, 1]))
print(equilibrium_point([-7, 1, 5, 2, -4, 3, 0]))
