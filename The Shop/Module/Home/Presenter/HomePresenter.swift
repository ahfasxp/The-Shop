//
//  HomePresenter.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Combine
import Foundation

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let getProductsUsecase: GetProductsUsecase
  private let getCategoriesUsecase: GetCategoriesUsecase

  @Published var products: [Product] = []
  @Published var categories: [String] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false

  init(getProductsUsecase: GetProductsUsecase, getCategoriesUsecase: GetCategoriesUsecase) {
    self.getProductsUsecase = getProductsUsecase
    self.getCategoriesUsecase = getCategoriesUsecase
  }

  func getProducts() {
    isLoading = true
    getProductsUsecase.execute()
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
        self.products = products
      })
      .store(in: &cancellables)
  }

  func getCategories() {
    isLoading = true
    getCategoriesUsecase.execute()
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
      }, receiveValue: { categories in
        self.categories = categories
      })
      .store(in: &cancellables)
  }
}
