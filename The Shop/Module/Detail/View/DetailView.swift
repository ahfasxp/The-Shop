//
//  DetailView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 22/02/23.
//

import AlertMessage
import CachedAsyncImage
import Core
import Product
import SwiftUI

struct DetailView: View {
  @ObservedObject var favoritePresenter: FavoritePresenter<Interactor<Any, [ProductDomain], GetFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<Int, ProductDomain, GetFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<[ProductDomain], Bool, AddFavoriteProductsRepository<FavoriteProductLocaleDataSource, ProductTransformer>>,
    Interactor<ProductDomain, Bool, DeleteFavoriteProductRepository<FavoriteProductLocaleDataSource, ProductTransformer>>>

  let product: ProductDomain

  // for action back view
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  @State private var isActive = false
  @State private var qty = 0

  var body: some View {
    ZStack(alignment: .bottom) {
      ZStack(alignment: .topLeading) {
        content
        btnBack
          .foregroundColor(.black)
      }

      floatingButton
    }.onAppear {
      favoritePresenter.getFavorite(request: product.id ?? 0)
    }
    .navigationBarBackButtonHidden(true)
    .alertMessage(isPresented: $isActive, type: .banner) {
      HStack {
        Spacer()

        Image(systemName: "checkmark.circle")
          .resizable()
          .frame(width: 35, height: 35)
          .foregroundColor(.black)
          .padding()

        Text("Added successfully!")
          .foregroundColor(.black)

        Spacer()
      }
      .padding(.top, 10)
      .background(.white)
    }
  }
}

extension DetailView {
  private var content: some View {
    GeometryReader { g in
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: 0.0) {
          HStack(alignment: .top, spacing: 0.0) {
            Spacer()

            CachedAsyncImage(url: URL(string: product.image ?? "")) { image in
              image.resizable()
            } placeholder: {
              Color.gray
            }
            .scaledToFit()
            .frame(width: g.size.width * 0.85, height: 400)
            .cornerRadius(50, corners: .bottomLeft)
          }
          .padding(.vertical, 10)
          .padding(.bottom, 25)

          Text(product.title ?? "Product Name")
            .font(.system(size: 24))
            .fontWeight(.medium)
            .lineLimit(2)
            .padding(.leading, 25)
            .padding(.bottom, 10)

          HStack(alignment: .center, spacing: 0.0) {
            Text("$ \(String(product.price ?? 0.0))")
              .font(.system(size: 30))
              .fontWeight(.bold)

            Spacer()

            Image(systemName: "plus")
              .frame(width: 30, height: 30)
              .background(Color(hex: "#F0F0F0"))
              .cornerRadius(10)
              .onTapGesture {
                qty += 1
              }

            Text(String(qty))
              .font(.system(size: 18))
              .fontWeight(.semibold)
              .padding(.horizontal)

            Image(systemName: "minus")
              .frame(width: 30, height: 30)
              .background(Color(hex: "#F0F0F0"))
              .cornerRadius(10)
              .onTapGesture {
                if qty > 0 {
                  qty -= 1
                }
              }
          }
          .padding(.horizontal, 25)
          .padding(.bottom, 10)

          HStack(alignment: .center, spacing: 0.0) {
            Image(systemName: "star.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 20, height: 20)
              .foregroundColor(Color(hex: "#F2C94C"))
              .padding(.trailing, 10)

            Text(String(product.rating.rate ?? 0.0))
              .font(.system(size: 18))
              .fontWeight(.bold)
              .padding(.trailing, 20)

            Text("(\(String(product.rating.count ?? 0)) reviews)")
              .font(.system(size: 14))
              .fontWeight(.semibold)
              .foregroundColor(Color(hex: "#808080"))
          }
          .padding(.horizontal, 25)
          .padding(.bottom, 11)

          Text(product.description ?? "Product Desc")
            .padding(.horizontal, 25)
            .padding(.bottom, 11)

          Spacer(minLength: 50)
        }
      }
    }
  }

  private var btnBack: some View {
    Button(action: {
      self.presentationMode.wrappedValue.dismiss()
    }) {
      HStack(alignment: .center, spacing: 0.0) {
        Image(systemName: "chevron.backward")
          .padding(10)
          .background(.white)
          .cornerRadius(10)
          .shadow(radius: 1)
      }
      .padding(.vertical, 10)
      .padding(.horizontal, 32)
    }
  }

  private var floatingButton: some View {
    HStack {
      Button(action: {
        if favoritePresenter.isFavorite {
          favoritePresenter.deleteFavorite(request: product)
        } else {
          favoritePresenter.addFavorite(request: [product])
        }
      }) {
        Image(systemName: favoritePresenter.isFavorite ? "heart.fill" : "heart")
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
          .padding(18)
          .background(Color(hex: "#F0F0F0"))
          .foregroundColor(.black)
          .cornerRadius(10)
      }
    }
    .padding(.horizontal, 25)
  }
}

// struct DetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    let detailPresenter = Injection().detailPresenter()
//    let cartPresenter = Injection().cartPresenter()
//    let product = Product(
//      id: 1,
//      title: "Product Name",
//      price: 12.0,
//      description: "Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.",
//      category: "Category",
//      image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
//      rating: Rating(rate: 3.9, count: 120))
//    DetailView(detailPresenter: detailPresenter, cartPresenter: cartPresenter, product: product)
//  }
// }
