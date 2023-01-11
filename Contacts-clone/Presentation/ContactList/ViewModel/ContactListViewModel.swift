//
//  ContactListViewModel.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import Foundation

import RxCocoa
import RxSwift


final class ContactListViewModel: ViewModelType {
  private let disposeBag = DisposeBag()
  private final let fetchContactListUseCase: FetchContactListUseCase
  
  struct Input {
    var trigger: Signal<Void>
    var createContactTrigger: Driver<Void>
  }
  
  struct Output {
    var title: Driver<String>
    var fetching: Driver<Bool>
    var createContact: Driver<Void>
    var contactList: Driver<[Contact]>
  }
  
  // MARK: - Init
  
  init(fetchContactListUseCase: FetchContactListUseCase) {
    self.fetchContactListUseCase = fetchContactListUseCase
  }
  
  func transform(input: Input) -> Output {
    let activityIndicator = ActivityIndicator()
    let errorTracker = ErrorTracker()
    
    let title = Driver<String>.just("Contacts")
    let fetching = activityIndicator.asDriver()
    let contactList = input.trigger.flatMapLatest {
      return self.fetchContactListUseCase.execute()
        .trackActivity(activityIndicator)
        .trackError(errorTracker)
        .asDriverOnErrorJustComplete()
        .asDriver()
    }
    let createContact = input.createContactTrigger
      .do(onNext: { print($0) })
    
    return Output(title: title,
                  fetching: fetching,
                  createContact: createContact,
                  contactList: contactList)
  }
}

