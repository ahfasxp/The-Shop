//
//  GetProductsInteractor.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Combine
import Foundation

protocol GetProductsUsecase {
  func execute() -> AnyPublisher<[Product], Error>
}

class GetProductsInteractor: GetProductsUsecase {
  private let repository: MainRepositoryProtocol

  required init(repository: MainRepositoryProtocol) {
    self.repository = repository
  }

  func execute() -> AnyPublisher<[Product], Error> {
    repository.getProducts()
  }
}
