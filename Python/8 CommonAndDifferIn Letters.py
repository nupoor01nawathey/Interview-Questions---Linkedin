# TCS Round 2
# 1. Find out common letters in both input strings
# 2. Find out all the unique letters in both input strings
# 3. Find out letters which is present in one string but not in second string and vice versa


input1='hello world'
input2='rockthejvmsparkscala'

def f_common_letters(input1: str, input2: str)->list:
  input1_set=set(input1)
  input2_set=set(input2)
  print('All letters', input1_set,input2_set) # here pipe operator can also be used
  print('Common letters', input1_set&input2_set)
  print('Present in 1st input but not in 2nd', input1_set-input2_set)
  print('Present in 2nd input but not in 1st', input2_set-input1_set)
  
f_common_letters(input1,input2)