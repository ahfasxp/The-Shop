//
//  Injection.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Category
import Core
import Foundation
import Product
import RealmSwift

final class Injection: NSObject {
  private let realm = try? Realm()

  func provideProducts<U: UseCase>() -> U where U.Request == String, U.Response == [ProductDomain] {
    let remote = GetProductsRemoteDataSource(endpoint: Endpoints.Gets.products.url, endpointByCategory: Endpoints.Gets.productsByCategory.url)

    let mapper = ProductTransformer()

    let repository = GetProductsRepository(
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideCategories<U: UseCase>() -> U where U.Request == Any, U.Response == [String] {
    let remote = GetCategoriesRemoteDataSource(endpoint: Endpoints.Gets.categories.url)

    let repository = GetCategoriesRepository(remoteDataSource: remote)

    return Interactor(repository: repository) as! U
  }

  func provideFavoriteProducts<U: UseCase>() -> U where U.Request == Any, U.Response == [ProductDomain] {
    let locale = FavoriteProductLocaleDataSource(realm: realm!)

    let mapper = ProductTransformer()

    let repository = GetFavoriteProductsRepository(
      localeDataSource: locale,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideFavoriteProduct<U: UseCase>() -> U where U.Request == Int, U.Response == ProductDomain {
    let locale = FavoriteProductLocaleDataSource(realm: realm!)

    let mapper = ProductTransformer()

    let repository = GetFavoriteProductRepository(
      localeDataSource: locale,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideAddFavoriteProduct<U: UseCase>() -> U where U.Request == [ProductDomain], U.Response == Bool {
    let locale = FavoriteProductLocaleDataSource(realm: realm!)

    let mapper = ProductTransformer()

    let repository = AddFavoriteProductsRepository(
      localeDataSource: locale,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideDeleteFavoriteProduct<U: UseCase>() -> U where U.Request == ProductDomain, U.Response == Bool {
    let locale = FavoriteProductLocaleDataSource(realm: realm!)

    let mapper = ProductTransformer()

    let repository = DeleteFavoriteProductRepository(
      localeDataSource: locale,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }
}
