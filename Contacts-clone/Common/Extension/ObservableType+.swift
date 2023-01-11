//
//  ObservableType+.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/11.
//

import Foundation

import RxCocoa
import RxSwift

extension ObservableType where Element == Bool {
  /// Boolean not operator
  public func not() -> Observable<Bool> {
    return self.map(!)
  }
}

extension SharedSequenceConvertibleType {
  func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
    return map { _ in }
  }
}

extension ObservableType {
  func asDriverOnErrorJustComplete() -> Driver<Element> {
    return asDriver { error in
      return Driver.empty()
    }
  }
  
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
}
