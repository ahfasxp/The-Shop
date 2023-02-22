//
//  APICall.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Foundation

struct API {
  static let baseUrl = "https://fakestoreapi.com/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case products
    case categories

    public var url: String {
      switch self {
      case .products: return "\(API.baseUrl)products"
      case .categories: return "\(API.baseUrl)products/categories"
      }
    }
  }
}
