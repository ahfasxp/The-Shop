//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import CorePackage
import Foundation

public class FavoritePresenter<
  GetFavoritesUsecase: UseCase,
  GetFavoriteUsecase: UseCase,
  AddFavoriteUsecase: UseCase,
  DeleteFavoriteUsecase: UseCase
>: ObservableObject where
  GetFavoritesUsecase.Request == Any,
  GetFavoritesUsecase.Response == [ProductDomain],
  GetFavoriteUsecase.Request == Int,
  GetFavoriteUsecase.Response == ProductDomain,
  AddFavoriteUsecase.Request == [ProductDomain],
  AddFavoriteUsecase.Response == Bool,
  DeleteFavoriteUsecase.Request == ProductDomain,
  DeleteFavoriteUsecase.Response == Bool
{
  private var cancellables: Set<AnyCancellable> = []

  private let getFavoritesUsecase: GetFavoritesUsecase
  private let getFavoriteUsecase: GetFavoriteUsecase
  private let addFavoriteUsecase: AddFavoriteUsecase
  private let deleteFavoriteUsecase: DeleteFavoriteUsecase

  @Published public var list: GetFavoritesUsecase.Response = []
  @Published public var isFavorite: Bool = false
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(getFavoritesUsecase: GetFavoritesUsecase, getFavoriteUsecase: GetFavoriteUsecase, addFavoriteUsecase: AddFavoriteUsecase, deleteFavoriteUsecase: DeleteFavoriteUsecase) {
    self.getFavoritesUsecase = getFavoritesUsecase
    self.getFavoriteUsecase = getFavoriteUsecase
    self.addFavoriteUsecase = addFavoriteUsecase
    self.deleteFavoriteUsecase = deleteFavoriteUsecase
  }

  public func getFavorites(request: GetFavoritesUsecase.Request?) {
    isLoading = true
    getFavoritesUsecase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { products in
        self.list = products
      })
      .store(in: &cancellables)
  }

  public func getFavorite(request: GetFavoriteUsecase.Request) {
    getFavoriteUsecase.execute(request: request)
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

  public func addFavorite(request: AddFavoriteUsecase.Request) {
    addFavoriteUsecase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          break
        case .finished:
          self.getFavorites(request: nil)
        }
      }, receiveValue: { _ in
        self.isFavorite = true
      }).store(in: &cancellables)
  }

  public func deleteFavorite(request: DeleteFavoriteUsecase.Request) {
    deleteFavoriteUsecase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          break
        case .finished:
          self.getFavorites(request: nil)
        }
      }, receiveValue: { _ in
        self.isFavorite = false
      }).store(in: &cancellables)
  }
}
