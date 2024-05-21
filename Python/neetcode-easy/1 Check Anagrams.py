#
# Approach:
# If length of both strings is the same then could be anagrams of each other else not
# Create Hash Map with key as string's char with it's corresponding count
# Use get() to default count to 0 if a key is not found (will happen in 1st occurance of a char)
# Compare 2 Hash Maps
#


def check_anagrams(s: str, t: str):
    if len(s) != len(t):
        return False
    
    count_s, count_t = {} , {}

    for i in range(len(s)):
        count_s[s[i]] = 1 + count_s.get(s[i], 0)
        count_t[t[i]] = 1 + count_t.get(t[i], 0)

    if count_s != count_t:
        return False

    return True

print(check_anagrams('anagram','margana'))
print(check_anagrams('cat','car'))

# 
# Searching a Key in Dictionary takes O(1) time
# Time complexity O(s+t)
# Space complexity 0(s+t)
#
