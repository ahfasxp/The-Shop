//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import Core
import Foundation
import RealmSwift

public struct FavoriteProductLocaleDataSource: LocaleDataSource {
  public typealias Request = String
  public typealias Response = ProductModuleEntity
  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(request: String?) -> AnyPublisher<[ProductModuleEntity], Error> {
    return Future<[ProductModuleEntity], Error> { completion in
      let favorites: Results<ProductModuleEntity> = realm.objects(ProductModuleEntity.self)
      completion(.success(favorites.toArray(ofType: ProductModuleEntity.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entities: [ProductModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try self.realm.write {
          for product in entities {
            self.realm.add(product, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func get(id: Int) -> AnyPublisher<ProductModuleEntity, Error> {
    return Future<ProductModuleEntity, Error> { completion in
      if let favorite = realm.object(ofType: ProductModuleEntity.self, forPrimaryKey: id) {
        completion(.success(favorite))
      } else {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func delete(entity: ProductModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        let favorite = realm.object(ofType: ProductModuleEntity.self, forPrimaryKey: entity.id)
        try realm.write {
          if let favorited = favorite {
            realm.delete(favorited)
            completion(.success(true))
          }
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func update(id: Int, entity: ProductModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
