//
//  MainRepository.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Combine
import Foundation

protocol MainRepositoryProtocol {
  func getProducts() -> AnyPublisher<[Product], Error>
  func getCategories() -> AnyPublisher<[String], Error>
  func getProductsByCategory(_ category: String) -> AnyPublisher<[Product], Error>
  func setFavorite(for product: Product) -> AnyPublisher<Bool, Error>
  func getFavorites() -> AnyPublisher<[Product], Error>
  func getFavorite(id: Int) -> AnyPublisher<Product, Error>
}

final class MainRepository: NSObject {
  typealias MainInstance = (RemoteDataSource, LocaleDataSource) -> MainRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(remote: RemoteDataSource, locale: LocaleDataSource) {
    self.remote = remote
    self.locale = locale
  }

  static let sharedInstance: MainInstance = { remoteRepo, localeRepo in
    MainRepository(remote: remoteRepo, locale: localeRepo)
  }
}

extension MainRepository: MainRepositoryProtocol {
  func getProducts() -> AnyPublisher<[Product], Error> {
    return self.remote.getProducts()
      .map { ProductMapper.mapProductsResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func getCategories() -> AnyPublisher<[String], Error> {
    return self.remote.getCategories()
      .eraseToAnyPublisher()
  }

  func getProductsByCategory(_ category: String) -> AnyPublisher<[Product], Error> {
    return self.remote.getProductsByCategory(category)
      .map { ProductMapper.mapProductsResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func setFavorite(for product: Product) -> AnyPublisher<Bool, Error> {
    return self.locale.setFavorite(for: ProductMapper.domainProductToEntity(input: product))
      .eraseToAnyPublisher()
  }

  func getFavorites() -> AnyPublisher<[Product], Error> {
    return self.locale.getFavorites()
      .map { ProductMapper.mapProductsEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func getFavorite(id: Int) -> AnyPublisher<Product, Error> {
    return self.locale.getFavorite(id: id)
      .map { ProductMapper.productEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
}
