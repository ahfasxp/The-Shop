//
//  Presenter.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import Combine
import Foundation

class FavoritePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let favoriteUsecase: FavoriteUsecase

  @Published var favorites: [Product] = []
  @Published var errorMessageFavorites: String = ""
  @Published var isLoadingFavorites: Bool = false
  @Published var isErrorFavorites: Bool = false

  init(
    favoriteUsecase: FavoriteUsecase
  ) {
    self.favoriteUsecase = favoriteUsecase
  }

  func getFavorites() {
    isLoadingFavorites = true
    favoriteUsecase.getFavorites()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessageFavorites = error.localizedDescription
          self.isErrorFavorites = true
          self.isLoadingFavorites = false
        case .finished:
          self.isLoadingFavorites = false
        }
      }, receiveValue: { products in
        self.favorites = products
      })
      .store(in: &cancellables)
  }

  func setFavorite(product: Product) {
    favoriteUsecase.setFavorite(for: product)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          break
        case .finished:
          self.getFavorites()
        }
      }, receiveValue: { isFavorite in
        print("isFavorite \(isFavorite)")
      }).store(in: &cancellables)
  }
}
