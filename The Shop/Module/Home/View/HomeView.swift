//
//  HomeView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import CachedAsyncImage
import Foundation
import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter

  @State private var selectedCat = "All"

  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 0.0) {
        HeaderView(headerName: "The Shop")
          .padding(.bottom, 20)
        listCategory
        listProduct
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }.onAppear {
      if presenter.products.isEmpty && presenter.categories.isEmpty {
        presenter.getProducts()
        presenter.getCategories()
      }
    }
  }
}

extension HomeView {
  private var listCategory: some View {
    ZStack {
      if !presenter.isLoadingCategories {
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
              presenter.getProducts()
            }

            ForEach(presenter.categories, id: \.self) { category in
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
                presenter.getProductsByCategory(selectedCat)
              }
            }
          }
          .padding(.leading, 17)
          .padding(.bottom, 20)
        }
      }
    }
  }

  private var listProduct: some View {
    ZStack {
      if presenter.isLoadingProducts {
        VStack {
          Text("Loading...")
          ProgressView()
        }
      } else if presenter.isErrorProducts {
        CustomEmptyView(
          image: "exclamationmark.triangle",
          title: presenter.errorMessageProducts
        )
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          GridStack(rows: 5, columns: 2) { row, col in
            if self.presenter.products.indices.contains(row * 2 + col) {
              VStack(alignment: .leading) {
                ZStack(alignment: .bottomTrailing) {
                  CachedAsyncImage(url: URL(string: self.presenter.products[row * 2 + col].image ?? "")) { image in
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
                }

                Text(self.presenter.products[row * 2 + col].title ?? "Pruduct Name")
                  .font(.system(size: 14))
                  .fontWeight(.regular)
                  .padding(.top, 10)
                  .padding(.bottom, 5)

                Text("$ \(String(self.presenter.products[row * 2 + col].price ?? 0.0))")
                  .font(.system(size: 14))
                  .fontWeight(.bold)
              }
              .padding(.horizontal, 10)
              .padding(.bottom, 15)
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
    HomeView(presenter: homePresenter)
  }
}
