//
//  DefaultCreateContactUseCase.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import RxSwift

final class DefaultCreateContactUseCase {
  private let contactRepository: ContactRepository
  
  init(contactRepository: ContactRepository) {
    self.contactRepository = contactRepository
  }
}

extension DefaultCreateContactUseCase: CreateContactUseCase {
  func execute(with information: Information) -> Observable<Result<Contact, ErrorType>> {
    return contactRepository.createContact(for: information)
  }
}
