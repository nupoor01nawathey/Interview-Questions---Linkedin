nums = [0, 1, 2, 2, 3, 0, 4, 2]
# val=2 appears 3 times in nums and total length is 8
# so after removing count of val=2 , k should be returned as 5

val = 2

k = 0

for i in range(len(nums)):
  if nums[i] != val:
    nums[k] = nums[i]
    k += 1
    
print(k)

