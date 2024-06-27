# Tiger Analytics hashtag#python hashtag#dsa Interview Question for DE, DA and DS role.

# =============== 🤞 
# Write a python code to flatten a nested list without using any inbuilt functions.
# Input -
# i = [2,3,[50,80,[100,200],90],34]

# Output -
# o = [2, 3, 50, 80, 100, 200, 90, 34]

lst = [2,3,[50,80,[100,200],90],34]

flatten_elemets = []
def flatten_list(l):
  if isinstance(l, list):
    for ele in l:
      flatten_list(ele)
  else:
    flatten_elemets.append(l)
    
flatten_list(lst)

print(flatten_elemets)