'''
Given two strings ransomNote and magazine, return true if ransomNote can be constructed 
by using the letters from magazine and false otherwise.
Each letter in magazine can only be used once in ransomNote.

Example 1:
Input: ransomNote = "a", magazine = "b"
Output: false

Example 2:
Input: ransomNote = "aa", magazine = "ab"
Output: false

Example 3:
Input: ransomNote = "aa", magazine = "aab"
Output: true
'''

def ransom_note(ransomNote, magazine):
  d = {}
  
  for c in magazine:
    if c not in d:
      d[c] = 1
    else:
      d[c] += 1
  
  for c in ransomNote:
    if c not in d or d[c] <= 0:
      return False
    else:
      d[c] -= 1
  
  return True
  
print(ransom_note("a", "b"))    # False 
print(ransom_note("aa", "ab"))  # False  
print(ransom_note("aa", "aab")) # True


# Time: O(m+n)
# Space: If alphabates only then 26 chars so (1)
