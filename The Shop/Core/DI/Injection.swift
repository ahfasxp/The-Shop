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

  private func getProductsInteractor() -> GetProductsUsecase {
    return GetProductsInteractor(repository: provideRepository())
  }

  private func getCategoriesInteractor() -> GetCategoriesUsecase {
    return GetCategoriesInteractor(repository: provideRepository())
  }

  func homePresenter() -> HomePresenter {
    return HomePresenter(getProductsUsecase: getProductsInteractor(), getCategoriesUsecase: getCategoriesInteractor())
  }
}
