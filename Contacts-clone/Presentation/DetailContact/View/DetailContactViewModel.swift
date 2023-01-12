//
//  DetailContactViewModel.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import RxCocoa
import RxSwift

final class DetailContactViewModel: ViewModelType {
  private let contact: Contact
  
  struct Input {
  }
  
  struct Output {
    var name: Driver<String>
    var company: Driver<String>
    var number: Driver<String>
  }
  
  // MARK: - Init
  
  init(contact: Contact) {
    self.contact = contact
  }
  
  func transform(input: Input) -> Output {
    let contact = Driver.just(self.contact)
    let name = contact
      .map { contact -> String in
        let firstName = contact.firstName ?? ""
        let lastName = contact.lastName ?? ""
        return firstName + lastName
      }
      .asDriver(onErrorJustReturn: "")
    let company = contact.map { $0.company ?? "" }.asDriver(onErrorJustReturn: "")
    let number = contact.map { $0.number }.asDriver(onErrorJustReturn: "")
    return Output(name: name, company: company, number: number)
  }
}
