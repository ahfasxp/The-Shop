//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Foundation
import RealmSwift

public class ProductModuleEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var price: Double = 0.0
  @objc dynamic var desc: String = ""
  @objc dynamic var category: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var rate: Double = 0.0
  @objc dynamic var count: Int = 0

  override public static func primaryKey() -> String? {
    return "id"
  }
}
