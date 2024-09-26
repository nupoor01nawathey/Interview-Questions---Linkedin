def longest_substring_without_repetition(s):
    max_length = 0
    char_index = {}
    start = 0
    longest_substring = ""

    for end in range(len(s)):
      if s[end] in char_index:
          start = max(start, char_index[s[end]] + 1)
      char_index[s[end]] = end
      if end - start + 1 > max_length:
          max_length = end - start + 1
          longest_substring = s[start:end+1]

    return max_length, longest_substring
  

print(longest_substring_without_repetition("FAVTUTOR"))
print(longest_substring_without_repetition("pwwkew"))
print(longest_substring_without_repetition("python"))
