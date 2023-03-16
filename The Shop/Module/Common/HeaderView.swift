//
//  HeaderView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import SwiftUI

struct HeaderView: View {
  let headerName: String

  var body: some View {
    HStack {
      Spacer()

      Text(headerName)
        .font(.title)
        .fontWeight(.semibold)
      Spacer()
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
