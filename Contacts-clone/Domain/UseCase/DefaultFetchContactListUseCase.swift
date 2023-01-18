//
//  ContactUseCase.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/10.
//

import Foundation

import RxSwift

final class DefaultFetchContactListUseCase {
  private let contactRepository: ContactRepository
  
  init(contactRepository: ContactRepository) {
    self.contactRepository = contactRepository
  }
}

extension DefaultFetchContactListUseCase: FetchContactListUseCase {
  func execute() -> Observable<Result<[Contact], ErrorType>> {
    return contactRepository.fetchContactList()
  }
}
