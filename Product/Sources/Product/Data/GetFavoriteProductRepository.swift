//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import CorePackage

public struct GetFavoriteProductRepository<
  ProductLocaleDataSource: LocaleDataSource,
  Transformer: Mapper
>: Repository
  where
  ProductLocaleDataSource.Response == ProductModuleEntity,
  Transformer.Entity == ProductModuleEntity,
  Transformer.Domain == ProductDomain
{
  public typealias Request = Int
  public typealias Response = ProductDomain

  private let _localeDataSource: ProductLocaleDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: ProductLocaleDataSource,
    mapper: Transformer
  ) {
    self._localeDataSource = localeDataSource
    self._mapper = mapper
  }

  public func execute(request: Int?) -> AnyPublisher<ProductDomain, Error> {
    return _localeDataSource.get(id: request!)
      .map { _mapper.entityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
