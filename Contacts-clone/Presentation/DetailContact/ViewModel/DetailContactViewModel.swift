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
  private let deleteContactUseCase: DeleteContactUseCase
  private let coordinator: ContactListCoordinator
  
  struct Input {
    var deleteTrigger: Signal<Void>
  }
  
  struct Output {
    var name: Driver<String>
    var company: Driver<String>
    var number: Driver<String>
    var deleteContact: Driver<Void>
  }
  
  // MARK: - Init
  
  init(contact: Contact,
       deleteContactUseCase: DeleteContactUseCase,
       coordinator: ContactListCoordinator) {
    self.contact = contact
    self.deleteContactUseCase = deleteContactUseCase
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    let errorTracker = ErrorTracker()
    let deleteContact = input.deleteTrigger
      .withUnretained(self)
      .flatMapLatest { (owner, _ ) in
        return owner.deleteContactUseCase.execute(with: owner.contact)
          .trackError(errorTracker)
          .map { result -> Void in
            switch result {
            case .success:
              owner.coordinator.closeViewController()
            case .failure:
              break
            }
          }
          .asDriverOnErrorJustComplete()
    }
    let contact = Driver.just(self.contact)
    let name = contact
      .map { contact -> String in
        let firstName = contact.information.firstName
        let lastName = contact.information.lastName
        return firstName + lastName
      }
      .asDriver(onErrorJustReturn: "")
    let company = contact.map { $0.information.company }.asDriver(onErrorJustReturn: "")
    let number = contact.map { $0.information.number }.asDriver(onErrorJustReturn: "")
    
    return Output(name: name,
                  company: company,
                  number: number,
                  deleteContact: deleteContact)
  }
}
