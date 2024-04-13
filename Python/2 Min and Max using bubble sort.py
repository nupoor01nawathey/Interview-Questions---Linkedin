# To find the minimum element in a given array of integers, you can use the min() function in Python. Here's an example along with an explanation:

def sort_lst(arr):
	n = len(arr)
	for i in range(n):
		for j in range(0, n - i - 1):
			if arr[j] > arr[j + 1]:
				arr[j], arr[j + 1] = arr[j + 1], arr[j]
				
arr = [ 100, 12, -3, 4, 50 ]
sort_lst(arr)

print("Min array is:", arr[0])
print("Max array is:", arr[-1])
