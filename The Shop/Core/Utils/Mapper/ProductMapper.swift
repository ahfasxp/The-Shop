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
    let productEntity = ProductEntity()
    productEntity.id = product.id ?? 0
    productEntity.title = product.title ?? ""
    productEntity.price = product.price ?? 0.0
    productEntity.desc = product.description ?? ""
    productEntity.category = product.category ?? ""
    productEntity.image = product.image ?? ""
    productEntity.rate = product.rating.rate ?? 0.0
    productEntity.count = product.rating.count ?? 0
    return productEntity
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
        rate: productEntity.rate,
        count: productEntity.count
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
        description: result.desc,
        category: result.category,
        image: result.image,
        rating: Rating(
          rate: result.rate,
          count: result.count
        )
      )
    }
  }
}
