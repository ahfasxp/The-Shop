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

  static func domainProductToEntity(
    input product: Product
  ) -> ProductEntity {
    let entity = ProductEntity()
    entity.id = product.id ?? 0
    entity.title = product.title ?? ""
    entity.price = product.price ?? 0.0
    entity.desc = product.description ?? ""
    entity.category = product.category ?? ""
    entity.image = product.image ?? ""

    let ratingEntity = RatingEntity()
    ratingEntity.rate = product.rating.rate ?? 0.0
    ratingEntity.count = product.rating.count ?? 0

    entity.rating = ratingEntity
    return entity
  }

  static func productEntityToDomain(
    input productEntity: ProductEntity
  ) -> Product {
    return Product(
      id: productEntity.id,
      title: productEntity.title,
      price: productEntity.price,
      description: productEntity.desc,
      category: productEntity.category,
      image: productEntity.image,
      rating: Rating(
        rate: productEntity.rating?.rate,
        count: productEntity.rating?.count
      )
    )
  }

  static func mapProductsEntityToDomain(
    input productEntity: [ProductEntity]
  ) -> [Product] {
    return productEntity.map { result in
      Product(
        id: result.id,
        title: result.title,
        price: result.price,
        description: result.description,
        category: result.category,
        image: result.image,
        rating: Rating(
          rate: result.rating?.rate ?? 0.0,
          count: result.rating?.count ?? 0
        )
      )
    }
  }
}
