# Approach:
# Start from end of the list , check non space char
# Increment counter of word
# Find next space and return counter
# 

def length_of_last_word(s):
    i, length = len(s)-1, 0

    while s[i] == " ":
        i -= 1
    
    while i >= 0 and s[i] != " ":
        length += 1
        i -= 1
    
    return length

print(length_of_last_word("Python"))
print(length_of_last_word("Hello World"))
print(length_of_last_word("   fly me   to   the moon"))


# 
# Time complexity O(N) - Iterating from end of list 
# Space complexity - O(1) Extra variable for counter
#