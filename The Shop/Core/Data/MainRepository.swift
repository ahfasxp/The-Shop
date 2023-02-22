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
}

final class MainRepository: NSObject {
  typealias MainInstance = (RemoteDataSource) -> MainRepository

  fileprivate let remote: RemoteDataSource

  private init(remote: RemoteDataSource) {
    self.remote = remote
  }

  static let sharedInstance: MainInstance = { remoteRepo in
    MainRepository(remote: remoteRepo)
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
}
