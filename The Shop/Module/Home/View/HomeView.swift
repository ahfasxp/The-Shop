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

  var body: some View {
    ZStack {
      if presenter.isLoading {
        VStack {
          Text("Loading...")
          ProgressView()
        }
      } else if presenter.isError {
        CustomEmptyView(
          image: "exclamationmark.square",
          title: presenter.errorMessage
        )
      } else {
        VStack(alignment: .leading, spacing: 0.0) {
          HeaderView(headerName: "The Shop")
            .padding(.bottom, 20)
          listCategory
          listProduct
        }
      }
    }.onAppear {
      if self.presenter.products.count == 0 {
        self.presenter.getProducts()
      }
    }
  }
}

extension HomeView {
  private var listCategory: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 25.0) {
        VStack {
          Text("A")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(15)
          Text("Category")
        }
      }
      .padding(.leading, 17)
      .padding(.bottom, 20)
    }
  }

  private var listProduct: some View {
    ZStack {
      if presenter.products.isEmpty {
        VStack {
          CustomEmptyView(
            image: "exclamationmark.square",
            title: "The Products is empty"
          )
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
