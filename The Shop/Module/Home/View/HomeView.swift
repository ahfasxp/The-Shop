//
//  HomeView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 20/02/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 0.0) {
      HeaderView(headerName: "The Shop")
        .padding(.bottom, 20)
      listCategory
      listProduct
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

        VStack {
          Text("B")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(15)
          Text("Category")
        }

        VStack {
          Text("B")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(15)
          Text("Category")
        }

        VStack {
          Text("B")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(15)
          Text("Category")
        }

        VStack {
          Text("B")
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(.gray)
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
    ScrollView(.vertical, showsIndicators: false) {
      GridStack(rows: 5, columns: 2) { _, _ in
        VStack(alignment: .leading) {
          ZStack(alignment: .bottomTrailing) {
            Image("item")
              .resizable()
              .scaledToFill()
              .cornerRadius(16)

            Image("icon-bag")
              .resizable()
              .scaledToFit()
              .frame(width: 30, height: 30)
              .padding(10)
          }

          Text("Meal")
            .font(.system(size: 14))
            .fontWeight(.regular)
            .padding(.top, 10)
            .padding(.bottom, 5)

          Text("$ 12.00")
            .font(.system(size: 14))
            .fontWeight(.bold)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 15)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
