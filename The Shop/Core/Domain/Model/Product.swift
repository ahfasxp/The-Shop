//
//  Product.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Foundation

struct Product: Equatable, Hashable {
  let id: Int?
  let title: String?
  let price: Double?
  let description: String?
  let category: String?
  let image: String?
  let rating: Rating
}

struct Rating: Equatable, Hashable {
  let rate: Double?
  let count: Int?
}
