//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import CorePackage

public struct GetFavoriteProductsRepository<
  ProductLocaleDataSource: LocaleDataSource,
  Transformer: Mapper
>: Repository
  where
  ProductLocaleDataSource.Response == ProductModuleEntity,
  Transformer.Entity == ProductModuleEntity,
  Transformer.Domain == ProductDomain
{
  public typealias Request = Any
  public typealias Response = [ProductDomain]

  private let _localeDataSource: ProductLocaleDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: ProductLocaleDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDataSource
    _mapper = mapper
  }

  public func execute(request: Request?) -> AnyPublisher<[ProductDomain], Error> {
    return _localeDataSource.list(request: nil)
      .map { _mapper.mapEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
