//
//  HomeView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import CachedAsyncImage
import SwiftUI

struct HomeView: View {
  @ObservedObject var homePresenter: HomePresenter
  @ObservedObject var cartPresenter: CartPresenter

  @State private var selectedCat = "All"

  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      HeaderView(cartPresenter: cartPresenter, headerName: "The Shop")
        .padding(.bottom, 20)
      listCategory
      listProduct
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      Spacer()
    }.onAppear {
      if homePresenter.products.isEmpty && homePresenter.categories.isEmpty {
        homePresenter.getProducts()
        homePresenter.getCategories()
      }
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
            homePresenter.getProducts()
          }

          if !homePresenter.isLoadingCategories {
            ForEach(homePresenter.categories, id: \.self) { category in
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
                homePresenter.getProductsByCategory(selectedCat)
              }
            }
          } else {
            ProgressView()
          }
        }
        .padding(.leading, 17)
        .padding(.bottom, 20)
      }
    }
  }

  private var listProduct: some View {
    ZStack {
      if homePresenter.isLoadingProducts {
        VStack {
          Text("Loading...")
          ProgressView()
        }
      } else if homePresenter.isErrorProducts {
        CustomEmptyView(
          image: "exclamationmark.triangle",
          title: homePresenter.errorMessageProducts
        )
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          GridStack(rows: 5, columns: 2) { row, col in
            if homePresenter.products.indices.contains(row * 2 + col) {
              let detailPresenter = Injection().detailPresenter()
              let product = homePresenter.products[row * 2 + col]
              NavigationHelper.linkBuilder(destination: DetailView(detailPresenter: detailPresenter, cartPresenter: cartPresenter, product: product)) {
                ProductTile(cartPresenter: cartPresenter, product: product)
              }
              .buttonStyle(PlainButtonStyle())
            } else {
              VStack {
                EmptyView()
              }.frame(maxWidth: .infinity)
            }
          }
        }
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let homePresenter = Injection().homePresenter()
    let cartPresenter = Injection().cartPresenter()
    HomeView(
      homePresenter: homePresenter,
      cartPresenter: cartPresenter
    )
  }
}
