//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Alamofire
import Combine
import Core
import Foundation
 
public struct GetProductsRemoteDataSource: RemoteDataSource {
  public typealias Request = String
  public typealias Response = [ProductResponse]
    
  private let _endpoint: String
  private let _endpointByCategory: String
    
  public init(endpoint: String, endpointByCategory: String) {
    _endpoint = endpoint
    _endpointByCategory = endpointByCategory
  }
    
  public func execute(request: String?) -> AnyPublisher<[ProductResponse], Error> {
    if request == nil {
      return Future<[ProductResponse], Error> { completion in
        if let url = URL(string: _endpoint) {
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
    } else {
      return Future<[ProductResponse], Error> { completion in
        let replaced = request!.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: _endpointByCategory + replaced) {
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
  }
}
