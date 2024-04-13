# Find the pair meaning sum of two elements should match the target, Output such pairs

# Input: 1,2,3,4,5 Target: 5
# Output: (1,4)(3,2)


def find_pairs(lst, target):
  pairs=[]
  seen=set()
  for num in lst:
    complement=target-num
    if complement in seen:
      pairs.append((num, complement))
    seen.add(num)
  return pairs

print(find_pairs([1,2,3,4,5], 5))
print(find_pairs([1,2,3,-4,5], -2))
