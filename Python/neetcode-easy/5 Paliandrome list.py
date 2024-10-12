#
# Approach:
# Define Left index=0 and right index=len(lst)-1
# Make sure l and r don't collide and check if left index matches with right
# If not means not paliandrome
# Increment l and decrement r
#

def is_paliandrome(lst):
    nums = []

    l, r = 0, len(lst)-1
    while l <= r:
        if lst[l] != lst[r]:
            return False
        l = l+1
        r = r-1
    return True
        

print(is_paliandrome('racecar'))
print(is_paliandrome('cat'))
print(is_paliandrome('naman'))

# 
# Searching a Key in Dictionary takes O(1) time
# Expected  Time complexity O(N) -> Converting singly linked list to Array
# Space complexity 0(N) -> Need extra space while converting linked list to array
#
