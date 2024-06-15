// SCALA EASY PROBLEMS 

// 1 Find last element from a list using tail recursion
def lastElem(numList: List[Int]): Int = {
	if(numList.length == 1) numList.head
	else lastElem(numList.tail)
}
numList = List(1,2,3,4,5)
lastElem(numList) // 5


// 2 Find neighbour elements
val numList = List(1,2,3,4,5)
val res = numList.map(x => (x, x+1, x+2))
println(res) // List((1,2,3), (2,3,4), (3,4,5), (4,5,6), (5,6,7))

// For flattened output 
val res = numList.map(x => List(x, x+1, x+2)).flatten
println(res) // List((1,2,3), (2,3,4), (3,4,5), (4,5,6), (5,6,7))




// 3 Pair Neighbour 
scala> val endLimit = 6
endLimit: Int = 6

scala> val lst = for(i <- 2 to endLimit by 2) yield List(i, i+1)
lst: scala.collection.immutable.IndexedSeq[List[Int]] = Vector(List(2, 3), List(4, 5), List(6, 7))

OR
scala> val num = 6
num: Int = 6

scala> val lst = (2 to num+1).toList
lst: List[Int] = List(2, 3, 4, 5, 6, 7)

scala> lst.sliding(2,2).toList
res0: List[List[Int]] = List(List(2, 3), List(4, 5), List(6, 7))


// 4 Flatten list
scala> val aList = List(1,2,3,List(4,5,6,List(7,8,9)))
aList: List[Any] = List(1, 2, 3, List(4, 5, 6, List(7, 8, 9)))

scala> def flatten(l: List[Any]): List[Any] = l match {
     | case Nil => Nil
     | case (h: List[_]) :: tail => flatten(h) ::: flatten(tail)
     | case h :: tail => h :: flatten(tail)
     | }
flatten: (l: List[Any])List[Any]

scala> println(flatten(aList))
List(1, 2, 3, 4, 5, 6, 7, 8, 9)



// 5 Print start Pattern
scala> def printPattern(n: Int): Unit = {
     | if(n == 0) return
     | println("*" * n)
     | printPattern(n-1)
     | }
printPattern: (n: Int)Unit

scala> printPattern(5)
*****
****
***
**
*


// 6 Get value from index started from the end of the list
scala> def getFromLast(l: List[Int], positionFromLast: Int) :Int = {
     | if (positionFromLast == l.size) l.head
     | else getFromLast(l.tail, positionFromLast)
     | }
getFromLast: (l: List[Int], positionFromLast: Int)Int

scala> getFromLast(List(1,2,3,4,5), 3)
res9: Int = 3


// 7 Word count from a list of names
val nameList = List("Manish Kumar", "Suraj Prasad", "Suraj Kumar", "Kumar Mahesh" , "Kumar")
nameList: List[String] = List(Manish Kumar, Suraj Prasad, Suraj Kumar, Kumar Mahesh, Kumar)

scala> 
	nameList.
	flatMap(x => x.split(" ")).
	groupBy( x => x ).
	mapValues(_.size)

res9: scala.collection.immutable.Map[String,Int] = Map(Kumar -> 4, Mahesh -> 1, Suraj -> 2, Manish -> 1, Prasad -> 1)

for(wordCount <- wordsCount) { println(s"Name is ${wordCount._1} and count is ${wordCount._2}") }
Name is Kumar and count is 4
Name is Mahesh and count is 1
Name is Suraj and count is 2
Name is Manish and count is 1
Name is Prasad and count is 1

To sort in desc count
scala> val wordsCount = nameList.flatMap(x => x.split(" ")).groupBy( x => x ).mapValues(_.size).toSeq.sortBy(x => -x._2)
wordsCount: Seq[(String, Int)] = Vector((Kumar,4), (Suraj,2), (Mahesh,1), (Manish,1), (Prasad,1))

