//
//  DefaultContactRepository.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/10.
//

import Foundation

import RxSwift

final class DefaultContactRepository {
  private let contactCoreDataStorage: ContactStorage
  
  init(coreDataStorage: ContactStorage) {
    self.contactCoreDataStorage = coreDataStorage
  }
}

extension DefaultContactRepository: ContactRepository {
  func fetchContactList() -> Observable<Result<[Contact], ErrorType>> {
    return contactCoreDataStorage.findAll().map { result in
      switch result {
      case .success(let responseDTO):
        return .success(responseDTO.map { $0.toDomain() })
      case .failure:
        return .failure(.coredataError)
      }
    }
  }
  
  func createContact(for information: Information) -> Observable<Result<Contact, ErrorType>> {
    return contactCoreDataStorage.createContact(information).map { result in
      switch result {
      case .success(let responseDTO):
        return .success(responseDTO.toDomain())
      case .failure:
        return .failure(.coredataError)
      }
    }
  }
  
  func deleteContact(for contact: Contact) -> Observable<Result<Void, ErrorType>> {
    let requestDTO = ContactRequestDTO(id: contact.id)
    return contactCoreDataStorage.deleteContact(for: requestDTO).map { result in
      switch result {
      case .success:
        return .success(())
      case .failure:
        return .failure(.coredataError)
      }
    }
  }
}
