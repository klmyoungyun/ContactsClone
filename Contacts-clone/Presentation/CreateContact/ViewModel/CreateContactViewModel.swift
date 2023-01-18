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
  private let disposeBag = DisposeBag()
  private let createContactUseCase: CreateContactUseCase
  private let coordinator: ContactListCoordinator
  
  struct Input {
    var cancelTrigger: Signal<Void>
    var createTrigger: Signal<Void>
    var firstName: Signal<String>
    var lastName: Signal<String>
    var company: Signal<String>
    var number: Signal<String>
    var note: Signal<String>
  }
  
  struct Output {
    var title: Driver<String>
    var doneButtonCanTap: Driver<Bool>
  }
  
  init(createContactUseCase: CreateContactUseCase,
       coordinator: ContactListCoordinator) {
    self.createContactUseCase = createContactUseCase
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    let errorTracker = ErrorTracker()
    
    let title = Driver<String>.just("New Contact")
    
    input.cancelTrigger
      .emit(onNext: { [weak self] in
        self?.coordinator.closeModal()
      })
      .disposed(by: disposeBag)
    
    let combinedInput = Signal.combineLatest(input.firstName,
                                             input.lastName,
                                             input.company,
                                             input.number,
                                             input.note)
    
    let information = combinedInput.map { Information(firstName: $0,
                                                  lastName: $1,
                                                  company: $2,
                                                  number: $3,
                                                  notes: $4) }
    
    input.createTrigger.withLatestFrom(information) { $1 }
      .flatMapLatest { information -> Signal<Result<Contact, ErrorType>> in
        return self.createContactUseCase.execute(with: information)
          .trackError(errorTracker)
          .asSignal(onErrorJustReturn: .failure(.coredataError))
      }
      .emit(onNext: { result in
        switch result {
        case .success(let model):
          self.coordinator.closeModal()
          self.coordinator.showDetailContactFlow(with: model)
        case .failure:
          break
        }
      })
      .disposed(by: disposeBag)
    
    let doneButtonCanTap = combinedInput.map { fname, lname, cname, num, com in
      return !fname.isEmpty || !lname.isEmpty || !cname.isEmpty || !num.isEmpty || !com.isEmpty
      }
      .startWith(false)
      .asDriver(onErrorJustReturn: false)
   
    return Output(title: title,
                  doneButtonCanTap: doneButtonCanTap)
  }
}
