//
//  ProductCard.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import CachedAsyncImage
import SwiftUI

struct FavoriteCard: View {
  @ObservedObject var favoritePresenter: FavoritePresenter
  let product: Product

  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      HStack(alignment: .top, spacing: 0.0) {
        CachedAsyncImage(url: URL(string: product.image ?? "")) { image in
          image.resizable()
        } placeholder: {
          Color.gray
        }
        .scaledToFit()
        .frame(width: 100, height: 100)
        .clipped()
        .cornerRadius(10)
        .padding(.trailing, 20)

        VStack(alignment: .leading) {
          Text(product.title ?? "Product Name")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.bottom, 5)

          Text("$ \(String(product.price ?? 0.0))")
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
            .onTapGesture {
              favoritePresenter.setFavorite(product: self.product)
            }
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

struct FavoriteCard_Previews: PreviewProvider {
  static var previews: some View {
    let favoritePresenter = Injection().favoritePresenter()
    let product = Product(
      id: 1,
      title: "Product Name",
      price: 12.0,
      description: "Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.",
      category: "Category",
      image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      rating: Rating(rate: 3.9, count: 120))

    FavoriteCard(
      favoritePresenter: favoritePresenter, product: product)
  }
}
