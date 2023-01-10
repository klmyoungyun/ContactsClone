//
//  Resolver.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import Foundation
import Swinject

final class Resolver {
  /// singleton object for resolve.
  static let shared = Resolver()

  private init() { }
  
  /// get the IOC container.
  private var container = buildContainer()
  
  func resolve<T>(_ type: T.Type) -> T {
    container.resolve(T.self)!
  }
}
