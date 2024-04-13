# Anagram problem Deloitte
# LISTEN = SILENT

def build_counts(string):
  cntr = {}
  for ch in string:
    if ch in cntr:
      cntr[ch]+=1
    else:
      cntr[ch]=1
  return cntr
  # short code for creating counter for each character from the string
  # cntr[ch]=cntr.setdefault(ch, 0) + 1

  
def f_anagram(string1, string2):
  c1=build_counts(string1.upper())
  c2=build_counts(string2.upper())
  return c1==c2
  
print(f_anagram('LISTEN', 'silENt')) 


# Time complexity O(N) -> 1 iteration for iterating over the array a
# Space complexity O(N) -> No extra space is required