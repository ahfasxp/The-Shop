//
//  ProductTile.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import CachedAsyncImage
import SwiftUI

struct ProductTile: View {
  @ObservedObject var cartPresenter: CartPresenter
  let product: Product

  var body: some View {
    VStack(alignment: .leading) {
      ZStack(alignment: .bottomTrailing) {
        CachedAsyncImage(url: URL(string: product.image ?? "")) { image in
          image.resizable()
        } placeholder: {
          Color.gray
        }
        .scaledToFit()
        .frame(width: 157, height: 200)
        .cornerRadius(16)

        Image("icon-bag")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .padding(10)
          .onTapGesture {
            cartPresenter.cart.append(product)
          }
      }

      Text(product.title ?? "Pruduct Name")
        .font(.system(size: 14))
        .fontWeight(.regular)
        .padding(.top, 10)
        .padding(.bottom, 5)

      Text("$ \(String(product.price ?? 0.0))")
        .font(.system(size: 14))
        .fontWeight(.bold)
    }
    .padding(.horizontal, 10)
    .padding(.bottom, 15)
  }
}

struct ProductTile_Previews: PreviewProvider {
  static var previews: some View {
    let cartPresenter = Injection().cartPresenter()
    let product = Product(
      id: 1,
      title: "Product Name",
      price: 12.0,
      description: "Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.",
      category: "Category",
      image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      rating: Rating(rate: 3.9, count: 120))

    ProductTile(cartPresenter: cartPresenter, product: product)
  }
}
