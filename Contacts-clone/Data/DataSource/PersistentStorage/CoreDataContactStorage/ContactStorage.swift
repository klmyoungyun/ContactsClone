//
//  ContactCoreDataStorage.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import Foundation

import RxSwift

protocol ContactStorage {
  func findAll() -> Observable<Result<[Contact], ErrorType>>
  func createContact(_ contact: Contact) -> Observable<Result<Contact, ErrorType>>
  func deleteContact(for requestDTO: ContactRequestDTO) -> Observable<Result<Contact, ErrorType>>
  func updateContact(for requestDTO: ContactRequestDTO) -> Observable<Result<Contact, ErrorType>>
}
