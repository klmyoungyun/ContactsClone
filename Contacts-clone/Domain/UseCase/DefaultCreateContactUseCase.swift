//
//  DefaultCreateContactUseCase.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import RxSwift

final class DefaultCreateContactUseCase: CreateContactUseCase {
  private let contactRepository: ContactRepository
  
  init(contactRepository: ContactRepository) {
    self.contactRepository = contactRepository
  }
  
  func execute(with contact: Contact) -> Observable<Result<Contact, Error>> {
    return contactRepository.createContact(with: contact)
  }
}
