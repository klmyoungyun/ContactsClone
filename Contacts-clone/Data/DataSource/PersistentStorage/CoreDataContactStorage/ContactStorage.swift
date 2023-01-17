//
//  ContactCoreDataStorage.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import Foundation

import RxSwift

protocol ContactCoreDataStorage {
  func findAll() -> Observable<Result<[Contact], ErrorType>>
  func findById(_ id: UUID)
  func createContact(_ contact: Contact) -> Observable<Result<Contact, ErrorType>>
  func deleteContact(_ id: UUID)
  func updateContact(id: UUID, contact: ContactRequestDTO)
}
