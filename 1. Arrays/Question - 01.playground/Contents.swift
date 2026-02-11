/*
 
 Questions -
 
 Given a binary array, find the maximum consecutives 1s in this array.
 
 Example:
 
 Input: [1,1,0,1,1,1]
 
 Output: 3
 
 */

import Foundation

func maxConsecutiveOnes(_ nums: [Int]) -> Int {
    
    var globalCount: Int = 0
    var localCount: Int = 0
    
    for num in nums {
        if num == 1 {
            localCount += 1
            globalCount = max(globalCount, localCount)
        } else {
            localCount = 0
        }
    }
    
    return globalCount
}


let inputArray: [Int] = [1,1,0,1,1,1]
maxConsecutiveOnes(inputArray)

