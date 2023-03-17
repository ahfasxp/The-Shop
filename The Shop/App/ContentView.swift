//
//  ContentView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import Category
import CorePackage
import Product
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var productsPresenter: GetListPresenter<String, ProductDomain, Interactor<String, [ProductDomain], GetProductsRepository<GetProductsRemoteDataSource, ProductTransformer>>>

  @EnvironmentObject var categoriesPresenter: GetListPresenter<Any, String, Interactor<Any, [String], GetCategoriesRepository<GetCategoriesRemoteDataSource>>>

  @EnvironmentObject var favoritePresenter: FavoritePresenter<Interactor<Any, [ProductDomain], GetFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<Int, ProductDomain, GetFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<[ProductDomain], Bool, AddFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<ProductDomain, Bool, DeleteFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>>

  var body: some View {
    NavigationView {
      TabView {
        HomeView(
          productsPresenter: productsPresenter,
          categoriesPresenter: categoriesPresenter,
          favoritePresenter: favoritePresenter
        )
        .tabItem {
          Label("", systemImage: "house")
        }

        FavoriteView(
          favoritePresenter: favoritePresenter
        )
        .tabItem {
          Label("", systemImage: "heart")
        }

        NotificationView()
          .tabItem {
            Label("", systemImage: "bell")
          }

        ProfileView()
          .tabItem {
            Label("", systemImage: "person")
          }
      }
      .accentColor(.black)
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}

// struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    let homePresenter = Injection().homePresenter()
//    let cartPresenter = Injection().cartPresenter()
//    ContentView()
//      .environmentObject(homePresenter)
//      .environmentObject(cartPresenter)
//  }
// }
