//
//  DefaultContactRepository.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/10.
//

import Foundation

import RxSwift

final class DefaultContactRepository {
  private let contactCoreDataStorage: ContactCoreDataStorage
  
  init(coreDataStorage: ContactCoreDataStorage) {
    self.contactCoreDataStorage = coreDataStorage
  }
}

extension DefaultContactRepository: ContactRepository {
  func fetchContactList() -> Observable<Result<[Contact], Error>> {
    return contactCoreDataStorage.findAll()
  }
  
  func createContact(with contact: Contact) -> Observable<Result<Contact, Error>> {
    return contactCoreDataStorage.createContact(contact)
  }
}
