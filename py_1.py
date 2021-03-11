# Ctrl +Shift + C for multiline comment 

print("hello")

def my_func(x):
  if x > 0:
    res = "You won, that is awsome!"
  else:
    res = "Sorry! you lost"
    
  return(res)
  
my_func(6)

# source: https://github.com/zhiwehu/Python-programming-exercises/commit/5dc0cfeb09d2ecd0909f499a345be83b28c81590

  # 35 head and 94 legs how many chicken and rabits
  
def rabit_chicken(heads, legs):
  count = 0
  count = legs - 2 * heads
  count = count / 2
  return count, (heads - count)
rabit, chicken = rabit_chicken(35, 90)
print("rabit = {}, Chicken = {}".format(rabit, chicken))
  
  
  # res = 'Not possible '
  # for i in range(heads+1):
  #   j = heads - i
  #   if 2*i + 4*j == legs:
  #     return i, j 
  #   return res, res
  #   
  #   
    
    
    
  
  
  
  
