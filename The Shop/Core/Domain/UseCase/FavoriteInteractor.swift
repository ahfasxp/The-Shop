//
//  FavoriteInteractor.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import Combine
import Foundation

protocol FavoriteUsecase {
  func getFavorites() -> AnyPublisher<[Product], Error>
  func setFavorite(for product: Product) -> AnyPublisher<Bool, Error>
}

class FavoriteInteractor: FavoriteUsecase {
  private let repository: MainRepositoryProtocol

  required init(repository: MainRepositoryProtocol) {
    self.repository = repository
  }

  func getFavorites() -> AnyPublisher<[Product], Error> {
    repository.getFavorites()
  }

  func setFavorite(for product: Product) -> AnyPublisher<Bool, Error> {
    repository.setFavorite(for: product)
  }
}
