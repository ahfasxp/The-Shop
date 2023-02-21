//
//  ProductMapper.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Foundation

final class ProductMapper {
  static func mapProductsResponseToDomain(
    input productResponse: [ProductResponse]
  ) -> [Product] {
    return productResponse.map { result in
      Product(
        id: result.id,
        title: result.title,
        price: result.price,
        description: result.description,
        category: result.category,
        image: result.image,
        rating: Rating(
          rate: result.rating.rate,
          count: result.rating.count
        )
      )
    }
  }
}
