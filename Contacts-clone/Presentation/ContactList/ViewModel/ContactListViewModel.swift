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
  private final let fetchContactListUseCase: FetchContactListUseCase
  private final let coordinator: ContactListCoordinator
  
  struct Input {
    var trigger: Signal<Void>
    var showDetailContactTrigger: Signal<Contact>
    var createContactTrigger: Signal<Void>
  }
  
  struct Output {
    var title: Driver<String>
    var fetching: Driver<Bool>
    var createContact: Driver<Void>
    var showDetailContact: Driver<Void>
    var contactList: Driver<[Contact]>
  }
  
  // MARK: - Init
  
  init(fetchContactListUseCase: FetchContactListUseCase,
       coordinator: ContactListCoordinator) {
    self.fetchContactListUseCase = fetchContactListUseCase
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    let activityIndicator = ActivityIndicator()
    let errorTracker = ErrorTracker()
    
    let title = Driver<String>.just("Contacts")
    let fetching = activityIndicator.asDriver()
    let contactList = input.trigger
      .flatMapLatest {
        return self.fetchContactListUseCase.execute()
          .trackActivity(activityIndicator)
          .trackError(errorTracker)
          .map { result -> [Contact] in
            switch result {
            case .success(let model):
              return model
            case .failure(let error):
              print(error.localizedDescription)
              return []
            }
          }
        .asDriverOnErrorJustComplete()
        .asDriver()
    }
    
    let showDetailContact = input.showDetailContactTrigger
      .do(onNext: { [weak self] contact in
        guard let self = self else { return }
        self.coordinator.showDetailContactFlow(with: contact)
      })
      .mapToVoid()
      .asDriver(onErrorJustReturn: ())
      
        
    let createContact = input.createContactTrigger
      .do(onNext: { [weak self] in
        guard let self = self else { return }
        self.coordinator.createContactFlow()
      })
      .asDriver(onErrorJustReturn: ())
    
    return Output(title: title,
                  fetching: fetching,
                  createContact: createContact,
                  showDetailContact: showDetailContact,
                  contactList: contactList)
  }
}

