//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

public struct ProductResponse: Decodable {
  let id: Int?
  let title: String?
  let price: Double?
  let description: String?
  let category: String?
  let image: String?
  let rating: RatingResponse
}

public struct RatingResponse: Decodable {
  let rate: Double?
  let count: Int?
}

public typealias ProductsResponse = [ProductResponse]
