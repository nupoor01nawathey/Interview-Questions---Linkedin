# Find the sum of all elements in a given array of integers using in Python. 

def sum_of_all_elements(lst):
  result=0
  for element in lst:
    result+=element
  return result
	
int_array = [1, 2, -3, 4, 5]
print(sum_of_all_elements(int_array))



# sum()
# reduce(operator.add, lst)