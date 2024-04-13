# Walmart, Given a sorted array ingest target element to fit into the sorted array

# Examples:

# Input : [3, 6, 8, 12, 15], target=7
# Output : [3, 6, 7, 8, 12, 15]


def ingest_element_in_sorted_array(lst, t):
  index=len(lst)
  for i in range(len(lst)):
    if lst[i] > t:
      index=i
      break
  if index==len(lst):
    lst=lst[:index] + [t]
  else:
    lst=lst[:index] + [t] + lst[index:]
  return lst

print(ingest_element_in_sorted_array([3, 6, 8, 12, 15], 7))


# Time Complexity: O(N)
# Auxiliary Space: O(1)