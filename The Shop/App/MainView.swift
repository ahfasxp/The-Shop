//
//  The_ShopApp.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import Category
import Core
import Product
import RealmSwift
import SwiftUI

let productsUseCase: Interactor<String, [ProductDomain],
  GetProductsRepository<GetProductsRemoteDataSource, ProductTransformer>> =
  Injection().provideProducts()

let categoriesUseCase: Interactor<Any, [String],
  GetCategoriesRepository<GetCategoriesRemoteDataSource>> =
  Injection().provideCategories()

let getFavoritesUsecase: Interactor<Any, [ProductDomain],
  GetFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>> = Injection().provideFavoriteProducts()

let getFavoriteUsecase: Interactor<Int, ProductDomain, GetFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>> = Injection().provideFavoriteProduct()

let addFavoritesUsecase: Interactor<[ProductDomain], Bool, AddFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>> = Injection().provideAddFavoriteProduct()

let deleteFavoritesUsecase: Interactor<ProductDomain, Bool, DeleteFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>> = Injection().provideDeleteFavoriteProduct()

@main
struct MainView: SwiftUI.App {
  let productsPresenter = GetListPresenter(useCase: productsUseCase)
  let categoriesPresenter = GetListPresenter(useCase: categoriesUseCase)
  let favoritePresenter = FavoritePresenter(getFavoritesUsecase: getFavoritesUsecase, getFavoriteUsecase: getFavoriteUsecase, addFavoriteUsecase: addFavoritesUsecase, deleteFavoriteUsecase: deleteFavoritesUsecase)

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(productsPresenter)
        .environmentObject(categoriesPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
