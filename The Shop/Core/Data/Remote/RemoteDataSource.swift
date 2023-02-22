//
//  RemoteDataSource.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 21/02/23.
//

import Alamofire
import Combine
import Foundation

protocol RemoteDataSourceProtocol: AnyObject {
  func getProducts() -> AnyPublisher<[ProductResponse], Error>
  func getCategories() -> AnyPublisher<[String], Error>
}

final class RemoteDataSource: NSObject {
  override private init() {}

  static let sharedInstance: RemoteDataSource = .init()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getProducts() -> AnyPublisher<[ProductResponse], Error> {
    return Future<[ProductResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.products.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: ProductsResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }

  func getCategories() -> AnyPublisher<[String], Error> {
    return Future<[String], Error> { completion in
      if let url = URL(string: Endpoints.Gets.categories.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: [String].self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
