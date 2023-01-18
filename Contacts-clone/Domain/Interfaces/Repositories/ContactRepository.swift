//
//  ContactRepository.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/10.
//

import Foundation

import RxSwift

protocol ContactRepository {
  func fetchContactList() -> Observable<Result<[Contact], ErrorType>>
  func createContact(for information: Information) -> Observable<Result<Contact, ErrorType>>
  func deleteContact(for contact: Contact) -> Observable<Result<Void, ErrorType>>
}
