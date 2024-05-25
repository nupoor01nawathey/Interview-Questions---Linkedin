/*
    .par works on non-associatives (will not work on foldLeft and foldRight as order of operation
    is maintained.
    Replace foldLeft with <your_lis>.par.aggregate()
 */

def fib(n:Int):Int = if(n < 2) 1 else fib(n-1)+fib(n-2)

for(i <- 30 to 15 by -1) { println(fib(i)) }
/*
  1346269
  832040
  514229
  317811
  196418
  121393
  75025
  46368
  28657
  17711
  10946
  6765
  4181
  2584
  1597
  987
*/

def fib(n:Int):Int = if(n < 2) 1 else fib(n-1)+fib(n-2)

for(i <- (30 to 15 by -1).par) { println(fib(i)) }
/*
  4181
  2584
  1597
  987
  10946
  6765
  196418
  17711
  75025
  121393
  46368
  28657
  514229
  317811
  832040
  1346269
 */

/*
  Race Condition Issue in case of var manipulated inside par collection iteration / loop
    1. Here i will be loaded from memory first
    2. Then perform addition
    3. In the end store value of i back in memory

    Since it's a parallel collection, there could be other thread which will trigger in between above
    3 steps and will not yield correct result

    Race condition mostly observed in mutable collections and var. Because you don't have ordered way
    of executing your logic.
 */
var i=0
for(j <- (1 to 1000000).par) { i+=1 }
println(i) // 1355233

