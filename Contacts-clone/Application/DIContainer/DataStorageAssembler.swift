//
//  DataStoreAssembler.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import Foundation

import Swinject

final class DataStorageAssembler: Assembly {
  func assemble(container: Container) {
    container.register(ContactStorage.self) { r in
      let coreDataStorage = CoreDataStorage.shared
      return CoreDataContactStorage(coreDataStorage: coreDataStorage)
    }
  }
}
