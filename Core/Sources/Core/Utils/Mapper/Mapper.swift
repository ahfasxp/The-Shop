//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Foundation

public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain

  func mapResponseToDomain(response: [Response]) -> [Domain]
  func mapEntityToDomain(entity: [Entity]) -> [Domain]
  func mapDomainToEntity(domain: [Domain]) -> [Entity]
  func responseToDomain(response: Response) -> Domain
  func entityToDomain(entity: Entity) -> Domain
  func domainToEntity(domain: Domain) -> Entity
}
