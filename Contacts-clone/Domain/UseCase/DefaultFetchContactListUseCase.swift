//
//  ContactUseCase.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/10.
//

import Foundation

import RxSwift

final class DefaultFetchContactListUseCase: FetchContactListUseCase {
  private let contactRepository: ContactRepository
  
  init(contactRepository: ContactRepository) {
    self.contactRepository = contactRepository
  }
  
  func fetchContactList() -> RxSwift.Observable<Result<[Contact], Error>> {
    return contactRepository.fetchContactList()
  }
}
