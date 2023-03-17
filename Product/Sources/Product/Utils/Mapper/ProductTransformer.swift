//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Core

public struct ProductTransformer: Mapper {
  public typealias Response = ProductResponse
  public typealias Entity = ProductModuleEntity
  public typealias Domain = ProductDomain

  public init() {}

  public func mapResponseToDomain(response: [ProductResponse]) -> [ProductDomain] {
    return response.map { result in
      ProductDomain(
        id: result.id,
        title: result.title,
        price: result.price,
        description: result.description,
        category: result.category,
        image: result.image,
        rating: RatingDomain(
          rate: result.rating.rate,
          count: result.rating.count
        )
      )
    }
  }

  public func mapEntityToDomain(entity: [ProductModuleEntity]) -> [ProductDomain] {
    return entity.map { result in
      ProductDomain(
        id: result.id,
        title: result.title,
        price: result.price,
        description: result.desc,
        category: result.category,
        image: result.image,
        rating: RatingDomain(
          rate: result.rate,
          count: result.count
        )
      )
    }
  }

  public func mapDomainToEntity(domain: [ProductDomain]) -> [ProductModuleEntity] {
    return domain.map { result in
      let newProduct = ProductModuleEntity()
      newProduct.id = result.id ?? 0
      newProduct.title = result.title ?? ""
      newProduct.price = result.price ?? 0.0
      newProduct.desc = result.description ?? ""
      newProduct.category = result.category ?? ""
      newProduct.image = result.image ?? ""
      newProduct.rate = result.rating.rate ?? 0.0
      newProduct.count = result.rating.count ?? 0
      return newProduct
    }
  }

  public func responseToDomain(response: ProductResponse) -> ProductDomain {
    return ProductDomain(
      id: response.id,
      title: response.title,
      price: response.price,
      description: response.description,
      category: response.category,
      image: response.image,
      rating: RatingDomain(
        rate: response.rating.rate,
        count: response.rating.count
      )
    )
  }

  public func entityToDomain(entity: ProductModuleEntity) -> ProductDomain {
    return ProductDomain(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.desc,
      category: entity.category,
      image: entity.image,
      rating: RatingDomain(
        rate: entity.rate,
        count: entity.count
      )
    )
  }

  public func domainToEntity(domain: ProductDomain) -> ProductModuleEntity {
    let newProduct = ProductModuleEntity()
    newProduct.id = domain.id ?? 0
    newProduct.title = domain.title ?? ""
    newProduct.price = domain.price ?? 0.0
    newProduct.desc = domain.description ?? ""
    newProduct.category = domain.category ?? ""
    newProduct.image = domain.image ?? ""
    newProduct.rate = domain.rating.rate ?? 0.0
    newProduct.count = domain.rating.count ?? 0
    return newProduct
  }
}
