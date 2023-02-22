//
//  GetProductByCategoryInteractor.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 22/02/23.
//

import Combine
import Foundation

protocol GetProductsByCategoryUsecase {
  func execute(_ category: String) -> AnyPublisher<[Product], Error>
}

class GetProductsByCategoryInteractor: GetProductsByCategoryUsecase {
  private let repository: MainRepositoryProtocol

  required init(repository: MainRepositoryProtocol) {
    self.repository = repository
  }

  func execute(_ category: String) -> AnyPublisher<[Product], Error> {
    repository.getProductsByCategory(category)
  }
}
