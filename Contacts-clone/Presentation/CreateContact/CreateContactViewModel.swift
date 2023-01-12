//
//  CreateContactViewModel.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import RxCocoa
import RxSwift

final class CreateContactViewModel: ViewModelType {
  private let createContactUseCase: CreateContactUseCase
  private let coordinator: ContactListCoordinator
  
  struct Input {
    var cancelTrigger: Signal<Void>
    var createTrigger: Signal<Contact>
  }
  
  struct Output {
    var cancel: Driver<Void>
    var create: Driver<Void>
  }
  
  init(createContactUseCase: CreateContactUseCase,
       coordinator: ContactListCoordinator) {
    self.createContactUseCase = createContactUseCase
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    let errorTracker = ErrorTracker()
    
    let cancel = input.cancelTrigger
      .do(onNext: { [weak self] in
        self?.coordinator.finish()
      })
      .asDriver(onErrorJustReturn: ())
        
    let create = input.createTrigger.flatMapFirst {
      return self.createContactUseCase.execute(with: $0)
        .trackError(errorTracker)
        .map { result -> Void in
          switch result {
          case.success(_):
            return
          case .failure(let error):
            print("create contact error: \(error.localizedDescription)")
            return
          }
        }
        .asDriverOnErrorJustComplete()
        .asDriver()
    }
    return Output(cancel: cancel,
                  create: create)
  }
}
