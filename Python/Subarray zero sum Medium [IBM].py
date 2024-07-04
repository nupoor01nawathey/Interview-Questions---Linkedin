# Input
# nums = [0, -1, 8, -5, -3, -7, 4, 2, 1]

# Output:
# [(0, 0), (2, 4), (2, 8)]

# Approach
# Get current_cum for each element while iterating on the list of elements
# If current_sum matches expected integer 0 append that index range in ans variable
# If current_sum is found in the hash_table that index+1 is our start index and current index i is ending index
# If current_sum not found in the hash_table insert current_sum as Key and index i as Value
#
#  0,  1, 2,  3, 4,  5,  6, 7, 8  <--- Index
# [0, -1, 8, -5, -3, -7, 4, 2, 1] <--- List of elements
#  0  -1  7  2   -1  -8 -4 -2  -1 <--- Current_sum , -1 is repeated and every repeatation is our boundry for output

nums = [0, -1, 8, -5, -3, -7, 4, 2, 1]

def zero_subarray_sum(lst, N):
  hash_table = {}
  ans = []
  current_sum = 0
  for i in range(N):
    current_sum += nums[i]
    if current_sum == 0:
      ans.append((0, i))
    if current_sum in hash_table:
      index_from_hash_table = hash_table[current_sum]
      ans.append((index_from_hash_table+1, i))
    else:
      hash_table[current_sum] = i
  return ans

ans = zero_subarray_sum(nums, len(nums))
print(ans)

