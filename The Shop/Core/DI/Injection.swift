//
//  Injection.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  // Repository
  private func provideRepository() -> MainRepositoryProtocol {
    let realm = try? Realm()

    let remote = RemoteDataSource.sharedInstance
    let locale = LocaleDataSource.sharedInstance(realm)

    return MainRepository.sharedInstance(remote, locale)
  }

  // Interactor
  private func provideHome() -> HomeUsecase {
    return HomeInteractor(repository: provideRepository())
  }

  private func provideFavorite() -> FavoriteUsecase {
    return FavoriteInteractor(repository: provideRepository())
  }

  private func provideDetail() -> DetailUsecase {
    return DetailInteractor(repository: provideRepository())
  }

  // Presenter
  func homePresenter() -> HomePresenter {
    return HomePresenter(homeUsecase: provideHome())
  }

  func favoritePresenter() -> FavoritePresenter {
    return FavoritePresenter(favoriteUsecase: provideFavorite())
  }

  func detailPresenter() -> DetailPresenter {
    return DetailPresenter(detailUsecase: provideDetail())
  }

  func cartPresenter() -> CartPresenter {
    return CartPresenter()
  }
}
