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
  
  func execute() -> Observable<[Contact]> {
    return contactRepository.fetchContactList()
      .map { result -> [Contact] in
        switch result {
        case .success(let model):
          return model
        case .failure(let error):
          print(error.localizedDescription)
          return []
        }
      }
  }
}
