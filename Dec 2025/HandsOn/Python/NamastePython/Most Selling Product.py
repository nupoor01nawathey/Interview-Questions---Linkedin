"""
You are given a single string containing names of products sold, separated by spaces.
Write a Python program to find the most frequently sold product and return it along with its frequency.
If multiple products have the same highest frequency, return the one that comes first in alphabetical order.

Example 1:
Input:
sales = "Laptop Fridge AC Laptop Fridge Mobile Laptop" 
Output:
('Laptop', 3)
Explanation:
The input string contains 7 product names.
"Laptop" appears 3 times — more than any other product —
so the output is ('Laptop', 3).

Example 2:
Input:
sales = "Fan Fan Cooler Cooler" 
Output:
('Cooler', 2)
Explanation:
Both "Fan" and "Cooler" appear 2 times.
Since there’s a tie, "Cooler" comes before "Fan" alphabetically,
so the output is ('Cooler', 2).

Constraints:
The input is a single string containing product names separated by spaces.
1 <= number of products <= 10^5
Each product name consists only of alphabetic characters.
"""

def get_most_selling_product(sales):
	words = sales.split(" ")
	hash_map = {}
	
	for word in words:
		if word not in hash_map:
			hash_map[word] = 1
		else:
			hash_map[word] += 1
			
	# for word in words: 
    #   hash_map[word] = hash_map.get(word, 0) + 1
			
	max_quantity = max(hash_map.values())
	
	most_selling_products = []
	for product, qty in hash_map.items():
		if qty == max_quantity:
			most_selling_products.append((product, qty))
	
	most_selling_products.sort()
	
	return most_selling_products[0]

print(get_most_selling_product("Laptop Fridge AC Laptop Fridge Mobile Laptop" )) # ('Laptop', 3)
print(get_most_selling_product("Fan Fan Cooler Cooler" )) # ('Cooler', 2)
print(get_most_selling_product("Laptop" ))                # ('Laptop', 1)
print(get_most_selling_product("A B C D E" ))             # ('A', 1)
print(get_most_selling_product("TV TV Fan Fan AC AC" ))   # ('AC', 2)

