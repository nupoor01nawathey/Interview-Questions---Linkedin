"""
You are given a list of daily sales amounts for a product and a target sales value.
Write a function to find the first day (1-indexed) when the cumulative sales crossed or equaled the given target.
If the sales never reach the target, return -1.


Example 1
Input:
sales = [100, 200, 300, 400, 500] target = 700
Output:
3
Explanation:
Day 1: 100
Day 2: 300
Day 3: 600
Day 4: 1000 ✅ (crossed 700)
First day cumulative sales ≥ target → Day 4
✅ Correct Output: 4

Example 2
Input:
sales = [50, 50, 50, 50] target = 200
Output:
4
Explanation:
50 + 50 + 50 + 50 = 200 → target reached on day 4.

Example 3
Input:
sales = [20, 40, 60] target = 200
Output:
-1
Explanation:
Cumulative never reaches target.
Constraints

1 <= len(sales) <= 10^5
0 <= sales[i] <= 10^4
1 <= target <= 10^9
"""

def first_day_to_reach_target(sales: list[int], target: int) -> int:
	current_sum = 0
	for i in range(len(sales)):
		current_sum += sales[i]
		if current_sum >= target:
			return(i+1)
	return(-1)

print(first_day_to_reach_target([100, 200, 300, 400, 500], 700)) # 4
print(first_day_to_reach_target([50, 50, 50, 50], 200))			 # 4
print(first_day_to_reach_target([20, 40, 60], 200))				 # -1
