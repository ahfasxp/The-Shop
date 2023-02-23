//
//  DetailInteractor.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import Combine
import Foundation

protocol DetailUsecase {
  func getFavorite(id: Int) -> AnyPublisher<Product, Error>
  func setFavorite(for product: Product) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUsecase {
  private let repository: MainRepositoryProtocol

  required init(repository: MainRepositoryProtocol) {
    self.repository = repository
  }

  func getFavorite(id: Int) -> AnyPublisher<Product, Error> {
    repository.getFavorite(id: id)
  }

  func setFavorite(for product: Product) -> AnyPublisher<Bool, Error> {
    repository.setFavorite(for: product)
  }
}
