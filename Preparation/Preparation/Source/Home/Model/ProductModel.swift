//
//  ProductModel.swift
//  Preparation
//
//  Created by Sparsh Singh on 15/02/26.
//

import Foundation

struct ProductModel : Decodable {
    let id              : String
    let title           : String
    let price           : Float
    let description     : String
    let category        : String
    let image           : String
    let rating          : Rate
}

struct Rate : Decodable {
    let rate            : Float
    let count           : Int
}
