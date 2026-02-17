//
//  ProductElement.swift
//  DemoProjectOne
//
//  Created by Sparsh Singh on 16/02/26.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let product = try? JSONDecoder().decode(Product.self, from: jsonData)

import Foundation

// MARK: - ProductElement
struct ProductElement: Codable {
    let id: Int?
    let title: String?
    let price: Float?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Float?
    let count: Int?
}

typealias Product = [ProductElement]
