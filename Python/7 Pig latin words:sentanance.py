# if starting charin word is vowel then add: -way
# Otherwise remove the first char and add with -ay
# Input: Pig Latin Eat
# Output: ig-Pay atin-Lay Eat-way

def pig_latin_word(word):
  vowels='AEIOUaeiou'
  if word[0] in vowels:
    return word+'-way'
  else:
    return word[1:]+"-"+word[0]+"ay"
  
print(pig_latin_word("Evening"))
print(pig_latin_word("Good Evening"))



def pig_latin_sentenance(sentenance):
  words=sentenance.split()
  pig_latin_words=[pig_latin_word(word) for word in words]
  return " ".join(pig_latin_words)
  
print(pig_latin_word("Pig Latin Eat"))
