//
//  ProductEntity.swift
//  The Shop
//
//  Created by OjekBro - Ahfas on 23/02/23.
//

import Foundation
import RealmSwift

class ProductEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var price: Double = 0.0
  @objc dynamic var desc: String = ""
  @objc dynamic var category: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var rate: Double = 0.0
  @objc dynamic var count: Int = 0

  override static func primaryKey() -> String? {
    return "id"
  }
}
