//
//  DeleteContactUseCase.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/17.
//

import Foundation

import RxSwift

protocol DeleteContactUseCase {
  func execute(with contact: Contact) -> Observable<Result<Void, ErrorType>>
}
