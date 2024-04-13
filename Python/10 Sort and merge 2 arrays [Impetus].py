arr1=[7,5,1,10,9]
arr2=[3,8,2,6,4]

for i in range(len(arr1)):
  for j in range(0, len(arr1)-1):
    if arr1[j]>arr1[j+1]:
      arr1[j],arr1[j+1]=arr1[j+1],arr1[j]
      
print(arr1)


for i in range(len(arr2)):
  for j in range(0, len(arr2)-1):
    if arr2[j]>arr2[j+1]:
      arr2[j],arr2[j+1]=arr2[j+1],arr2[j]
      
print(arr2)


m=len(arr1)
n=len(arr2)
last=m+n-1
arr3=[]
# merge from last to 0th index
while m>0 and n>0:
  if arr1[m-1] > arr2[n-1]:
    print("M: ",arr1[m-1])
    arr3[last]=arr1[m-1]
    m-=1
  else:
    arr3[last]=arr2[n-1]
    print("N: ", arr2[n-1])
    n-=1
  last-=1
  
print(arr3)
