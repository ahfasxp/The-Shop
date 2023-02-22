//
//  CartPresenter.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 22/02/23.
//

import Combine
import Foundation

class CartPresenter: ObservableObject {
  @Published var cart: [Product] = []
}
