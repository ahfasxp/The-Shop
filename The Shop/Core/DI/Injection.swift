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

  private func provideHome() -> HomeUsecase {
    return HomeInteractor(repository: provideRepository())
  }

  func homePresenter() -> HomePresenter {
    return HomePresenter(homeUsecase: provideHome())
  }

  func cartPresenter() -> CartPresenter {
    return CartPresenter()
  }
}
