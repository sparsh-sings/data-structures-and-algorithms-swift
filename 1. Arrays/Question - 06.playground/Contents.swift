/*
 
 Questions -
 
 Given two arrays, write a function to compute their intersection. No Unique Intersection Required.

 
 Example:
 
 Input: Array_1 = [1,2,2,1] & Array_2 = [2,2]
 
 Output: [2,2]
 
 */

import Foundation

class Vehicle {
    var tyre    : String
    var speed   : Int
    
    init(tyre: String, speed: Int) {
        self.tyre = tyre
        self.speed = speed
    }
}

class Car : Vehicle {
    var color : String
    init(color: String) {
        self.color = color
        super.init(tyre: "Black", speed: 20)
    }
}

let car = Car(color: "red")

car.speed = 10

print(car.speed)

