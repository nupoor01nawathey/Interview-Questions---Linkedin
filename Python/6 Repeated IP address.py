# Find repeated IP addresses

aList = ["10:1:12:1 aaa bbb","10:1:12:1 ccc bab","10:1:13:1 poa qwb"]
repeated_hash={}
for element in aList:
  ip=element.split()[0]
  if ip in repeated_hash:
    repeated_hash[ip]+=1
  else:
    repeated_hash[ip]=1
print(repeated_hash)
