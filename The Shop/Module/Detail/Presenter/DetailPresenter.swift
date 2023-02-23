//
//  DetailPresenter.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import Combine
import Foundation

class DetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let detailUsecase: DetailUsecase

  @Published var isFavorite: Bool = false

  init(
    detailUsecase: DetailUsecase
  ) {
    self.detailUsecase = detailUsecase
  }

  func addFavorite(product: Product) {
    detailUsecase.setFavorite(for: product)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          break
        case .finished:
          break
        }
      }, receiveValue: { isFavorite in
        self.isFavorite = isFavorite
      }).store(in: &cancellables)
  }

  func getFavorite(id: Int) {
    detailUsecase.getFavorite(id: id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.isFavorite = false
        case .finished:
          self.isFavorite = true
        }
      }, receiveValue: { product in
        print("product: \(product)")
      })
      .store(in: &cancellables)
  }
}
