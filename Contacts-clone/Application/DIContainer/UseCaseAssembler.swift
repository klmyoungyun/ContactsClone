//
//  UseCaseAssembler.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import Swinject

final class UseCaseAssembler: Assembly {
  func assemble(container: Container) {
    container.register(FetchContactListUseCase.self) { r in
      let contactRespository = r.resolve(ContactRepository.self)!
      let fetchContactListUseCase = DefaultFetchContactListUseCase(contactRepository:
                                                                    contactRespository)
      return fetchContactListUseCase
    }
  }
  
}
