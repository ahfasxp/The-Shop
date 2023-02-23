//
//  GetProductsInteractor.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Combine
import Foundation

protocol HomeUsecase {
  func getProducts() -> AnyPublisher<[Product], Error>
  func getCategories() -> AnyPublisher<[String], Error>
  func getProductsByCategory(_ category: String) -> AnyPublisher<[Product], Error>
}

class HomeInteractor: HomeUsecase {
  private let repository: MainRepositoryProtocol

  required init(repository: MainRepositoryProtocol) {
    self.repository = repository
  }

  func getProducts() -> AnyPublisher<[Product], Error> {
    repository.getProducts()
  }

  func getCategories() -> AnyPublisher<[String], Error> {
    repository.getCategories()
  }

  func getProductsByCategory(_ category: String) -> AnyPublisher<[Product], Error> {
    repository.getProductsByCategory(category)
  }
}
