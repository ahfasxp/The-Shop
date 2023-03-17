//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import CorePackage
 
public struct GetProductsRepository<
  ProductRemoteDataSource: RemoteDataSource,
  Transformer: Mapper
>: Repository where
  ProductRemoteDataSource.Request == String,
  ProductRemoteDataSource.Response == [ProductResponse],
  Transformer.Response == ProductResponse,
  Transformer.Domain == ProductDomain
{
  public typealias Request = String
  public typealias Response = [ProductDomain]
    
  private let _remoteDataSource: ProductRemoteDataSource
  private let _mapper: Transformer
    
  public init(
    remoteDataSource: ProductRemoteDataSource,
    mapper: Transformer)
  {
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
    
  public func execute(request: String?) -> AnyPublisher<[ProductDomain], Error>
  {
    return _remoteDataSource.execute(request: request)
      .map { _mapper.mapResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
}
