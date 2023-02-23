//
//  FavoriteView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import SwiftUI

struct FavoriteView: View {
  @ObservedObject var favoritePresenter: FavoritePresenter
  @ObservedObject var cartPresenter: CartPresenter

  var body: some View {
    VStack(alignment: .leading) {
      HeaderView(cartPresenter: cartPresenter, headerName: "Favorite")
      listFavorite
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      Spacer()
    }
    .onAppear {
      favoritePresenter.getFavorites()
    }
  }
}

extension FavoriteView {
  private var listFavorite: some View {
    ZStack {
      if !favoritePresenter.favorites.isEmpty {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading, spacing: 0.0) {
            ForEach(self.favoritePresenter.favorites, id: \.self) { favorite in
              let detailPresenter = Injection().detailPresenter()
              NavigationHelper.linkBuilder(
                destination: DetailView(
                  detailPresenter: detailPresenter,
                  cartPresenter: cartPresenter,
                  product: favorite
                )) {
                  FavoriteCard(
                    favoritePresenter: favoritePresenter, product: favorite
                  )
                }
            }
          }
        }
      } else {
        CustomEmptyView(
          image: "heart.slash",
          title: "Favorites Not Found"
        )
      }
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    let favoritePresenter = Injection().favoritePresenter()
    let cartPresenter = Injection().cartPresenter()
    FavoriteView(favoritePresenter: favoritePresenter, cartPresenter: cartPresenter)
  }
}
