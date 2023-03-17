//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

public struct ProductDomain: Equatable, Hashable {
  public let id: Int?
  public let title: String?
  public let price: Double?
  public let description: String?
  public let category: String?
  public let image: String?
  public let rating: RatingDomain
}

public struct RatingDomain: Equatable, Hashable {
  public let rate: Double?
  public let count: Int?
}
