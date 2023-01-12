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
    return Observable.just(.success([Contact(id: UUID(),
                                             firstName: "Kim",
                                             lastName: "Young Gyun",
                                             number: "010-9428-0039"),
                                     Contact(id: UUID(),
                                             firstName: "Lee",
                                             lastName: "Gang",
                                             company: "KAKAO",
                                             number: "010-1234-1234")]))
  }
  
  func createContact(with contact: Contact) -> Observable<Result<Void, Error>> {
    return Observable.just(.success(()))
  }
}
