# Given an integer array, find the sum of the largest contiguous subarray within the array. 
# For example, if the input is [−1, −3, 5, −4, 3, −6, 9, 2], then return 11 (because of [9, 2]). 
# Note that if all the elements are negative, you should return 0.

def max_sub_array_sum(a, size):
    curr_max = a[0]
    max_ending_here = a[0]

    for i in range(0, size):
        max_ending_here = max_ending_here + a[i]

        if max_ending_here < 0:
            max_ending_here = 0

        elif max_ending_here > curr_max:
            curr_max = max_ending_here

    if curr_max < 0:
        return 0
    
    return curr_max

a = [-1, -3, 5, -4, 3, -6, 9, 2]
a1 = [-2, -3, 4, -1, -2, 1, 5, -3]
a2 = [-13, -3, -25, -20, -3, -16, -23, -12, -5, -22, -15, -4, -7]
print ("Maximum contiguous sum is", max_sub_array_sum(a,len(a)))
print ("Maximum contiguous sum is", max_sub_array_sum(a1,len(a1)))
print ("Maximum contiguous sum is", max_sub_array_sum(a2,len(a2)))


# Time complexity : O(N)
# Space complexity : O(1)