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
 
public struct GetCategoriesRemoteDataSource: RemoteDataSource {
  public typealias Request = Any
  public typealias Response = [String]
    
  private let _endpoint: String
    
  public init(endpoint: String) {
    _endpoint = endpoint
  }
    
  public func execute(request: Any?) -> AnyPublisher<[String], Error> {
    return Future<[String], Error> { completion in
      if let url = URL(string: _endpoint) {
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
