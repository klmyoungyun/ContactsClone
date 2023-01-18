//
//  DefaultDeleteContactUseCase.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/17.
//

import Foundation

import RxSwift

final class DefaultDeleteContactUseCase {
  private let contactRepository: ContactRepository
  
  init(contactRepository: ContactRepository) {
    self.contactRepository = contactRepository
  }
}

extension DefaultDeleteContactUseCase: DeleteContactUseCase{
  func execute(with contact: Contact) -> Observable<Result<Void, ErrorType>> {
    return contactRepository.deleteContact(for: contact)
  }
}
