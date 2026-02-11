/*
 
 Questions -
 
 Given two arrays, write a function to compute their intersection

 
 Example:
 
 Input: Array_1 = [1,2,2,1] & Array_2 = [2,2]
 
 Output: [2]
 
 */

import Foundation

func findIntersection(_ arrayOne: [Int], _ arrayTwo :[Int]) -> [Int] {
    var setOne: Set<Int> = []
    var setTwo: Set<Int> = []

    for element in arrayOne {
        setOne.insert(element)
    }
    
    for element in arrayTwo {
        setTwo.insert(element)
    }
    
    var finalSet: Set<Int> = []
    
    for i in setOne {
        for j in setTwo {
            if i == j {
                finalSet.insert(i)
            }
        }
    }
    
    return Array(finalSet)
    
}

let inputArrayOne: [Int] = [1,1,1,2,2,3,3,3,5,6,4,4,3]
let inputArrayTwo: [Int] = [1,1,1,2,2,4,3]
let result = findIntersection(inputArrayOne, inputArrayTwo)
print(result)
