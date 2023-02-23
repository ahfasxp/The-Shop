//
//  HomePresenter.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Combine
import Foundation
import SwiftUI

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()

  private let homeUsecase: HomeUsecase

  @Published var products: [Product] = []
  @Published var errorMessageProducts: String = ""
  @Published var isLoadingProducts: Bool = false
  @Published var isErrorProducts: Bool = false

  @Published var categories: [String] = []
  @Published var errorMessageCategories: String = ""
  @Published var isLoadingCategories: Bool = false
  @Published var isErrorCategories: Bool = false

  init(
    homeUsecase: HomeUsecase
  ) {
    self.homeUsecase = homeUsecase
  }

  func getProducts() {
    isLoadingProducts = true
    homeUsecase.getProducts()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessageProducts = error.localizedDescription
          self.isErrorProducts = true
          self.isLoadingProducts = false
        case .finished:
          self.isLoadingProducts = false
        }
      }, receiveValue: { products in
        self.products = products
      })
      .store(in: &cancellables)
  }

  func getCategories() {
    isLoadingCategories = true
    homeUsecase.getCategories()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessageCategories = error.localizedDescription
          self.isErrorCategories = true
          self.isLoadingCategories = false
        case .finished:
          self.isLoadingCategories = false
        }
      }, receiveValue: { categories in
        self.categories = categories
      })
      .store(in: &cancellables)
  }

  func getProductsByCategory(_ category: String) {
    isLoadingProducts = true
    homeUsecase.getProductsByCategory(category)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessageProducts = error.localizedDescription
          self.isErrorProducts = true
          self.isLoadingProducts = false
        case .finished:
          self.isLoadingProducts = false
        }
      }, receiveValue: { products in
        self.products = products
      })
      .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    _ product: Product,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(product)) { content() }
  }
}
