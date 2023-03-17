//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import CorePackage
 
public struct GetCategoriesRepository<CategoryRemoteDataSource: RemoteDataSource>: Repository where
  CategoryRemoteDataSource.Response == [String]
{
  public typealias Request = Any
  public typealias Response = [String]
    
  private let _remoteDataSource: CategoryRemoteDataSource
    
  public init(remoteDataSource: CategoryRemoteDataSource)
  {
    _remoteDataSource = remoteDataSource
  }
    
  public func execute(request: Any?) -> AnyPublisher<[String], Error>
  {
    return _remoteDataSource.execute(request: nil)
      .eraseToAnyPublisher()
  }
}
