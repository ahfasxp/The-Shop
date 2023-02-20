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
      header
      listCategory
      content
    }
  }
}

extension HomeView {
  var header: some View {
    HStack {
      Image("icon-search")
        .resizable()
        .frame(width: 24, height: 24)
      Spacer()

      Text("The Shop")
        .font(.title)
        .fontWeight(.semibold)
      Spacer()

      Image("icon-cart")
        .resizable()
        .frame(width: 24, height: 24)
    }
    .padding()
    .padding(.bottom, 20)
  }

  var listCategory: some View {
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
    }
    .padding(.leading, 17)
    .padding(.bottom, 20)
  }

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      GridStack(rows: 5, columns: 2) { _, _ in
        ZStack {
          RoundedRectangle(
            cornerRadius: 1,
            style: .continuous
          )
          .fill(.white)

          VStack(alignment: .leading) {
            Image("item")
              .resizable()
              .scaledToFit()
              .cornerRadius(16)

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
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
