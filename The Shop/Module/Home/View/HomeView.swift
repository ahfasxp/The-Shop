//
//  HomeView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import CachedAsyncImage
import Category
import CorePackage
import Product
import SwiftUI

struct HomeView: View {
  @ObservedObject var productsPresenter: GetListPresenter<String, ProductDomain, Interactor<String, [ProductDomain], GetProductsRepository<GetProductsRemoteDataSource, ProductTransformer>>>

  @ObservedObject var categoriesPresenter: GetListPresenter<Any, String, Interactor<Any, [String], GetCategoriesRepository<GetCategoriesRemoteDataSource>>>

  @ObservedObject var favoritePresenter: FavoritePresenter<Interactor<Any, [ProductDomain], GetFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<Int, ProductDomain, GetFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<[ProductDomain], Bool, AddFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<ProductDomain, Bool, DeleteFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>>

  @State private var selectedCat = "All"

  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      HeaderView(headerName: "The Shop")
        .padding(.bottom, 20)
      listCategory
        .onAppear {
          if categoriesPresenter.list.count == 0 {
            categoriesPresenter.getList(request: nil)
          }
        }
      listProduct
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
          if productsPresenter.list.count == 0 {
            productsPresenter.getList(request: nil)
          }
        }
      Spacer()
    }
  }
}

extension HomeView {
  private var listCategory: some View {
    ZStack {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 25.0) {
          VStack {
            Text("A")
              .font(.system(size: 14))
              .fontWeight(.semibold)
              .padding(.vertical, 15)
              .padding(.horizontal, 20)
              .background((selectedCat == "All") ? .black : Color(hex: "#F5F5F5"))
              .foregroundColor((selectedCat == "All") ? .white : .black)
              .cornerRadius(15)
            Text("All")
              .frame(width: 80)
              .lineLimit(1)
          }
          .onTapGesture {
            selectedCat = "All"
            productsPresenter.getList(request: nil)
          }

          if categoriesPresenter.isLoading {
            ProgressView()
          } else if categoriesPresenter.isError {
            Text(categoriesPresenter.errorMessage)
          } else if categoriesPresenter.list.isEmpty {
            Text("Not Found")
          } else {
            ForEach(categoriesPresenter.list, id: \.self) { category in
              VStack {
                Text(String(category.prefix(1).uppercased()))
                  .font(.system(size: 14))
                  .fontWeight(.semibold)
                  .padding(.vertical, 15)
                  .padding(.horizontal, 20)
                  .background((selectedCat == category) ? .black : Color(hex: "#F5F5F5"))
                  .foregroundColor((selectedCat == category) ? .white : .black)
                  .cornerRadius(15)
                Text(category)
                  .frame(width: 80)
                  .lineLimit(1)
              }
              .onTapGesture {
                selectedCat = category
                productsPresenter.getList(request: selectedCat)
              }
            }
          }
        }
        .padding(.leading, 17)
        .padding(.bottom, 20)
      }
    }
  }

  private var listProduct: some View {
    ZStack {
      if productsPresenter.isLoading {
        VStack {
          Text("Loading...")
          ProgressView()
        }
      } else if productsPresenter.isError {
        CustomEmptyView(
          image: "exclamationmark.triangle",
          title: productsPresenter.errorMessage
        )
      } else if productsPresenter.list.isEmpty {
        CustomEmptyView(
          image: "heart.slash",
          title: "Products Not Found"
        )
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          GridStack(rows: 5, columns: 2) { row, col in
            if productsPresenter.list.indices.contains(row * 2 + col) {
              let product = productsPresenter.list[row * 2 + col]
              NavigationHelper.linkBuilder(destination: DetailView(
                favoritePresenter: favoritePresenter,
                product: product
              )) {
                ProductTile(product: product)
              }
              .buttonStyle(PlainButtonStyle())
            }
          }
        }
      }
    }
  }
}

// struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    let homePresenter = Injection().homePresenter()
//    let cartPresenter = Injection().cartPresenter()
//    HomeView(
//      homePresenter: homePresenter,
//      cartPresenter: cartPresenter
//    )
//  }
// }
