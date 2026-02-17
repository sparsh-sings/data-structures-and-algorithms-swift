/*
 
 Questions -
 
 Given two arrays, write a function to compute their intersection. No Unique Intersection Required.

 
 Example:
 
 Input: Array_1 = [1,2,2,1] & Array_2 = [2,2]
 
 Output: [2,2]
 
 */

import Foundation

func findIntersection(_ arrayOne: [Int], _ arrayTwo :[Int]) -> [Int] {
    
    if arrayOne.count > arrayTwo.count {
        return findMajor(arrayOne, arrayTwo)
    } else {
        return findMajor(arrayTwo, arrayOne)
    }
}

func findMajor(_ bigArray: [Int], _ smallArray : [Int]) -> [Int] {
    
    var sortedDict : [Int:Int] = [:]
    var resultArray : [Int] = []
    
    for nums in bigArray {
        sortedDict[nums, default:0] += 1
    }
    
    for value in smallArray {
        if let count = sortedDict[value], count > 0 {
            resultArray.append(value)
            sortedDict[value] = count - 1
            
            if sortedDict[value] == 0 {
                sortedDict[value] = nil
            }
        }
    }
    
    return resultArray
    
}

let inputArrayOne: [Int] = [1,2,2,1]
let inputArrayTwo: [Int] = [2,2]
let result = findIntersection(inputArrayOne, inputArrayTwo)
print(result)
