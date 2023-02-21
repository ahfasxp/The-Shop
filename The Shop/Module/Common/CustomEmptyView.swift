//
//  CustomEmptyView.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Foundation
import SwiftUI

struct CustomEmptyView: View {
  var image: String
  var title: String

  var body: some View {
    VStack {
      Image(systemName: image)
        .resizable()
        .scaledToFit()
        .frame(width: 50)

      Text(title)
        .font(.system(.body, design: .rounded))
    }
  }
}
