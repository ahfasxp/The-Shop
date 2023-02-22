//
//  FavoriteView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import SwiftUI

struct FavoriteView: View {
  @ObservedObject var cartPresenter: CartPresenter

  var body: some View {
    VStack(alignment: .leading) {
      HeaderView(cartPresenter: cartPresenter, headerName: "Favorite")
      listFavorite
      Spacer()
    }
  }
}

extension FavoriteView {
  private var listFavorite: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 0.0) {
        productCard
      }
    }
  }

  private var productCard: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      HStack(alignment: .top, spacing: 0.0) {
        Image("item")
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 100)
          .clipped()
          .cornerRadius(10)
          .padding(.trailing, 20)

        VStack(alignment: .leading) {
          Text("Coffe Table")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.bottom, 5)

          Text("$ 50.00")
            .font(.system(size: 16))
            .fontWeight(.bold)
            .padding(.bottom, 5)
        }

        Spacer()
        VStack(alignment: .leading) {
          Image(systemName: "x.circle")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
          Spacer()
          Image("icon-bag")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .padding(.bottom, 12)
        }
      }
      .frame(height: 100)
      .padding(.horizontal, 20)
      .padding(.vertical, 12)

      Divider()
        .frame(height: 1)
        .overlay(.gray)
        .padding(.horizontal, 20)
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    let cartPresenter = Injection().cartPresenter()
    FavoriteView(cartPresenter: cartPresenter)
  }
}
