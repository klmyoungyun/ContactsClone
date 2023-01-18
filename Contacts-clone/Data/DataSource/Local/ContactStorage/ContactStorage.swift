//
//  ContactCoreDataStorage.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import Foundation

import RxSwift

protocol ContactStorage {
  func findAll() -> Observable<Result<[ContactResponseDTO], ErrorType>>
  func createContact(_ information: Information) -> Observable<Result<ContactResponseDTO, ErrorType>>
  func deleteContact(for requestDTO: ContactRequestDTO) -> Observable<Result<Void, ErrorType>>
  func updateContact(for requestDTO: ContactRequestDTO) -> Observable<Result<ContactResponseDTO, ErrorType>>
}
