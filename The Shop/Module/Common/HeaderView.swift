//
//  HeaderView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import SwiftUI

struct HeaderView: View {
  var headerName: String

  var body: some View {
    HStack {
      Image("icon-search")
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
      Spacer()

      Text(headerName)
        .font(.title)
        .fontWeight(.semibold)
      Spacer()

      ZStack(alignment: .topTrailing) {
        Image("icon-cart")
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)

        Text("2")
          .font(.system(size: 10))
          .padding(.horizontal, 3)
          .padding(.vertical, 1)
          .background(.black)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
    }
    .padding()
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(headerName: "The Shop")
      .previewLayout(.sizeThatFits)
  }
}
