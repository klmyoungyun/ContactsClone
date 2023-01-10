//
//  DefaultContactRepository.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/10.
//

import Foundation

import RxSwift

final class DefaultContactRepository {
  init() {}
}

extension DefaultContactRepository: ContactRepository {
  func fetchContactList() -> Observable<Result<[Contact], Error>> {
    // fetch
    return .empty()
  }
}
