#
# Approach:
# More like a sliding window problem
# If current_sum < 0 initialize to 0
# Else add incoming num from list nums to max_sub_array
# Use max() between max_sub_array and current_sum and store in max_sub_array
#

def max_sub_arr_sum(nums):
    max_sub_arr_sum = nums[0]
    current_sum = 0
    for n in nums:
        if current_sum < 0:
            current_sum = 0
        current_sum += n
        max_sub_arr_sum = max(max_sub_arr_sum, current_sum)
    return max_sub_arr_sum

print(max_sub_arr_sum([-2,1,-3,4,-1,2,1,-5,4]))
print(max_sub_arr_sum([-1,-2,-3]))
print(max_sub_arr_sum([1,2,3]))

# 
# Searching a Key in Dictionary takes O(1) time
# Time complexity O(N) -> Iterating over list
# 