def rotate(nums, k):
  k = k % len(nums)

  def reverse(i, j):
    while i < j:
      nums[i], nums[j] = nums[j], nums[i]
      i, j = i + 1, j - 1

  # reverse nums
  reverse(0, len(nums) - 1)
  
  # reverse nums[:k]
  reverse(0, k - 1)
  
  # reverse nums[K:]
  reverse(k, len(nums) - 1)
  
  return nums
  
print(rotate([1,2,3,4,5], 2)) # [4, 5, 1, 2, 3]
