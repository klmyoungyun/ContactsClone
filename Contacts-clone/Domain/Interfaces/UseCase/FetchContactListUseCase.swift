//
//  ContactUseCaseProtocol.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/10.
//

import Foundation

import RxSwift

protocol FetchContactListUseCase {
  func fetchContactList() -> Observable<Result<[Contact], Error>>
}
