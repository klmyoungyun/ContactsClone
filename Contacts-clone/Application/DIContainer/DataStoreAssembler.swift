//
//  DataStoreAssembler.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import Foundation

import Swinject

final class DataStoreAssembler: Assembly {
  func assemble(container: Container) {
    container.register(ContactCoreDataStorage.self) { _ in
      return DefaultContactCoreDataStorage()
    }
  }
}
