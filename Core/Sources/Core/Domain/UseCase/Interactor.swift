//
//  File.swift
//
//
//  Created by OjekBro - Ahfas on 16/03/23.
//

import Combine
import Foundation

public struct Interactor<Request, Response, R: Repository>: UseCase
  where R.Request == Request, R.Response == Response
{
  private let _repository: R

  public init(repository: R) {
    _repository = repository
  }

  public func execute(request: Request?) -> AnyPublisher<Response, Error> {
    _repository.execute(request: request)
  }
}
