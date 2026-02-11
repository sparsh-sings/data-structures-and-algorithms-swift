/*
 
 Questions -
 
 Given an array of size n, find the majority element. The majority element is the element that appears more than [n/2] times.
 
 You may assume the array is non-empty and majority element always exist.
 
 Example:
 
 Input: [3,2,3]
 
 Output: 3
 
 */

import Foundation

func majorityElement(_ nums: [Int]) -> Int {
   
    var majorElement = nums[0]
    var counter : Int = 0
    
    for num in nums {
        if num == majorElement {
            counter += 1
        } else {
            counter -= 1
        }
        
        if counter == 0 {
            majorElement = num
            counter = 1
        }
        
    }
    return majorElement
}


let inputArray: [Int] = [3,2,3]
majorityElement(inputArray)


// Alternative approch using dictionary

func majorityElementUsingDictionary(_ nums: [Int]) -> Int {
    
    var numCount: [Int: Int] = [:]
    
    for num in nums {
        numCount[num, default: 0] += 1
    }
    
    var maxCount: Int = 0
    var majorElement: Int = 0
    
    for (key, value) in numCount {
        if value > maxCount {
            maxCount = value
            majorElement = key
        }
    }
    
    return majorElement
    
}

majorityElementUsingDictionary(inputArray)
