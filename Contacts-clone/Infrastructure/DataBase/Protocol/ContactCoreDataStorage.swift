//
//  ContactCoreDataStorage.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import Foundation

import RxSwift

protocol ContactCoreDataStorage {
  func findAll() -> Observable<Result<[Contact], Error>>
  func findById(_ id: UUID)
  func createContact(_ contactRequest: ContactRequestDTO)
  func deleteContact(_ id: UUID)
  func updateContact(id: UUID, contact: ContactRequestDTO)
}
