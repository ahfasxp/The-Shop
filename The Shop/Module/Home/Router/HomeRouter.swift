//
//  HomeRouter.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 22/02/23.
//

import Foundation
import SwiftUI

class HomeRouter {
  func makeDetailView(_ product: Product) -> some View {
    return DetailView(product: product)
  }
}
