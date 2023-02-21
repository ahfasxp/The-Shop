//
//  ProductsResponse.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Foundation

struct ProductResponse: Decodable {
  let id: Int?
  let title: String?
  let price: Double?
  let description: String?
  let category: String?
  let image: String?
  let rating: RatingResponse
}

struct RatingResponse: Decodable {
  let rate: Double?
  let count: Int?
}

typealias ProductsResponse = [ProductResponse]
