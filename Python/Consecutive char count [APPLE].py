# Apple - Consecutive count of each char from a string

s = "abcabbccab"      # a1b1c1a1b2c2a1b1

i = 0
n = len(s)
res = []
while i < n :
  j = i + 1
  count_i = 1
  while j < n and s[i] == s[j]:
    j += 1
    count_i += 1
  res.append(s[i] + str(count_i))
  i = j

print(s)
print("".join(res))
