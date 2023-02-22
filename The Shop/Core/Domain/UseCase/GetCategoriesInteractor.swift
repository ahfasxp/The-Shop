//
//  GetCategoriesInteractor.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 22/02/23.
//

import Combine
import Foundation

protocol GetCategoriesUsecase {
  func execute() -> AnyPublisher<[String], Error>
}

class GetCategoriesInteractor: GetCategoriesUsecase {
  private let repository: MainRepositoryProtocol

  required init(repository: MainRepositoryProtocol) {
    self.repository = repository
  }

  func execute() -> AnyPublisher<[String], Error> {
    repository.getCategories()
  }
}
