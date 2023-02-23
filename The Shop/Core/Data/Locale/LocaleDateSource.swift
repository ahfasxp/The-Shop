//
//  LocaleDateSource.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import Combine
import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol {
  func setFavorite(for productEntity: ProductEntity) -> AnyPublisher<Bool, Error>
  func getFavorites() -> AnyPublisher<[ProductEntity], Error>
  func getFavorite(id: Int) -> AnyPublisher<ProductEntity, Error>
}

final class LocaleDataSource {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func setFavorite(for productEntity: ProductEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let favorite = realm.object(ofType: ProductEntity.self, forPrimaryKey: productEntity.id)
          try realm.write {
            if let favorited = favorite {
              realm.delete(favorited)
              completion(.success(false))
            } else {
              realm.add(productEntity, update: .all)
              completion(.success(true))
            }
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func getFavorites() -> AnyPublisher<[ProductEntity], Error> {
    return Future<[ProductEntity], Error> { completion in
      if let realm = self.realm {
        let favorites: Results<ProductEntity> = realm.objects(ProductEntity.self)
        completion(.success(favorites.toArray(ofType: ProductEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func getFavorite(id: Int) -> AnyPublisher<ProductEntity, Error> {
    return Future<ProductEntity, Error> { completion in
      if let realm = self.realm {
        if let favorite = realm.object(ofType: ProductEntity.self, forPrimaryKey: id) {
          completion(.success(favorite))
        } else {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
