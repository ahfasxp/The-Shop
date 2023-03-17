//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import CorePackage

public struct DeleteFavoriteProductRepository<
  ProductLocaleDataSource: LocaleDataSource,
  Transformer: Mapper
>: Repository
  where
  ProductLocaleDataSource.Response == ProductModuleEntity,
  Transformer.Entity == ProductModuleEntity,
  Transformer.Domain == ProductDomain
{
  public typealias Request = ProductDomain
  public typealias Response = Bool

  private let _localeDataSource: ProductLocaleDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: ProductLocaleDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDataSource
    _mapper = mapper
  }

  public func execute(request: ProductDomain?) -> AnyPublisher<Bool, Error> {
    return _localeDataSource.delete(entity: _mapper.domainToEntity(domain: request!))
      .eraseToAnyPublisher()
  }
}
