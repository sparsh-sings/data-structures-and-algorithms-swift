/*
 
 Questions -
 
 Given an array of size n, find all the elements that appear more than [n/3] times.

 
 Example:
 
 Input: [1,1,1,2,2,3,3,3]
 
 Output: [1,3]
 
 */

import Foundation

func majorityElementArray(_ nums: [Int]) -> [Int] {
    var numDict : [Int:Int] = [:]
    
    for num in nums {
        numDict[num, default: 0] += 1
    }
    
    let threshold = nums.count / 3
    
    var finalArray: [Int] = []
    
    for (key,vlaue) in numDict {
        if vlaue > threshold{
            finalArray.append(key)
        }
    }
    
    return finalArray
}

let inputArray: [Int] = [1,1,1,2,2,3,3,3]
let result = majorityElementArray(inputArray)
print(result)
