//
//  FavoriteView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import CorePackage
import Product
import SwiftUI

struct FavoriteView: View {
  @ObservedObject var favoritePresenter: FavoritePresenter<Interactor<Any, [ProductDomain], GetFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<Int, ProductDomain, GetFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<[ProductDomain], Bool, AddFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<ProductDomain, Bool, DeleteFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>>

  var body: some View {
    VStack(alignment: .leading) {
      HeaderView(headerName: "Favorite")
      listFavorite
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      Spacer()
    }
    .onAppear {
      if favoritePresenter.list.count == 0 {
        favoritePresenter.getFavorites(request: nil)
      }
    }
  }
}

extension FavoriteView {
  private var listFavorite: some View {
    ZStack {
      if favoritePresenter.isLoading {
        VStack {
          Text("Loading...")
          ProgressView()
        }
      } else if favoritePresenter.isError {
        CustomEmptyView(
          image: "exclamationmark.triangle",
          title: favoritePresenter.errorMessage
        )
      } else if favoritePresenter.list.isEmpty {
        CustomEmptyView(
          image: "heart.slash",
          title: "Favorites Not Found"
        )
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 0.0) {
            ForEach(favoritePresenter.list, id: \.self) { product in
              NavigationHelper.linkBuilder(
                destination: DetailView(
                  favoritePresenter: favoritePresenter,
                  product: product
                )) {
                  FavoriteCard(
                    favoritePresenter: favoritePresenter,
                    product: product
                  )
                }
            }
          }
        }
      }
    }
  }
}

// struct FavoriteView_Previews: PreviewProvider {
//  static var previews: some View {
//    let favoritePresenter = Injection().favoritePresenter()
//    FavoriteView(favoritePresenter: favoritePresenter)
//  }
// }
