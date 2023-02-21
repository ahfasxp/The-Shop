//
//  Injection.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Foundation

final class Injection: NSObject {
  private func provideRepository() -> MainRepositoryProtocol {
    let remote = RemoteDataSource.sharedInstance

    return MainRepository.sharedInstance(remote)
  }

  func getProductsInteractor() -> GetProductsUsecase {
    let repository = provideRepository()
    return GetProductsInteractor(repository: repository)
  }

  func homePresenter() -> HomePresenter {
    return HomePresenter(getProductsUsecase: getProductsInteractor())
  }
}
