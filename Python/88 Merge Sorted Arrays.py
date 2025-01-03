nums1 = [2,2,3,0,0,0] # [1,2,3,0,0,0]
m=3 # length of index not the last index of nums1
nums2 = [1,5,6] # [2,5,6]
n=3 # length of index not the last index of nums2

last = m + n - 1

while m > 0 and n > 0:
  if nums1[m-1] > nums2[n-1]:
    nums1[last] = nums1[m-1]
    m-=1
  else:
    nums1[last] = nums2[n-1]
    n-=1
  last-=1


# Assuming nums2[0] > nums1[0] in that case swaping of elements wont happen
# with just above code
# Need to iterate for nums2 so that all remaning elements are appended
# in the beginning of nums1 until they exist
while n > 0:    
  nums1[last] = nums2[n-1]
  n, last = n-1, last-1
    
print(nums1)


# nums1=[1, 2, 2, 3, 5, 6]
# nums2=[2,5,6]
# output [1, 2, 2, 3, 5, 6]

# nums1=[2, 2, 2, 3, 5, 6] --> This is the edge case code from 22-24 would handle
# nums2=[1,5,6]
# output [1, 2, 2, 3, 5, 6]





