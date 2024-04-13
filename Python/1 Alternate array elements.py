# Create a new array from two given arrays by alternating their elements code in python

def alternate_array_elements(lst1, lst2):
  merged_lst = []
  min_len = min(len(lst1), len(lst2))
  
  for i in range(min_len):
  	merged_lst.append(lst1[i])
  	merged_lst.append(lst2[i])
  
  merged_lst += lst1[min_len:] + lst2[min_len:]

  return merged_lst

lst1 = [1, 2, 3, 4, 5]
lst2 = ['a', 'b', 'c']
print(alternate_array_elements(lst1,lst2))


# Time Complexity: O(n), where n is the length of the merged list.
# Space Complexity: O(n), where n is the length of the merged list