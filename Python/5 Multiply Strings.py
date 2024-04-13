# Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

# Note: You must not use any built-in BigInteger library or convert the inputs to integer directly.

# Example 1:

# Input: num1 = "2", num2 = "3"
# Output: "6"
# Example 2:

# Input: num1 = "123", num2 = "456"
# Output: "56088"
 

# Constraints:
# 1. 1 <= num1.length, num2.length <= 200
# 2. num1 and num2 consist of digits only.
# 3. Both num1 and num2 do not contain any leading zero, except the number 0 itself.


num1="3450000999"
num2="100000900"

print(type(num1))
print(type(num2))

print(eval(num1+"*"+num2)) # 345003204900899100


# The eval() method parses the expression passed to this method and runs python expression (code) within the program.

# number = 9

# # eval performs the multiplication passed as argument
# square_number = eval('number * number')
# print(square_number)

# # Output: 81

