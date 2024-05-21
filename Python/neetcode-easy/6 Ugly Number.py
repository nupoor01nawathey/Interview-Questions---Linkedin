# Approach:
# An ugly number is a positive integer whose prime factors are limited to 2, 3 and 5
# Iterate over 2, 3 and 5 and extarct module if it matches 0 then use / to reach to remainder
# If remainder is 1 that means it's an ugly number
# 


def is_ugly(n):
    if n <= 0:
        return False

    for prime_numbers in [2,3,5]:
        while n % prime_numbers == 0:
            n = n // prime_numbers

    return n == 1

print(is_ugly(20))
print(is_ugly(13))
print(is_ugly(30))


# 
# Time complexity O(log of base 2 of N) 
#
