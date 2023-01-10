//
//  ContactListViewModel.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import Foundation

import RxCocoa
import RxSwift

protocol ContactListViewModelInput {
  var viewWillAppear: PublishRelay<Void> { get }
}

protocol ContactListViewModelOutput {
  var activate: Driver<Bool> { get }
  var contactList: Driver<[Contact]> { get }
}

protocol ContactListViewModelType: ContactListViewModelInput,
                                   ContactListViewModelOutput {
  var input: ContactListViewModelInput { get }
  var output: ContactListViewModelOutput { get }
}

final class ContactListViewModel: ContactListViewModelType {
  private let disposeBag = DisposeBag()
  private final let fetchContactListUseCase: FetchContactListUseCase
  
  var input: ContactListViewModelInput { return self }
  var output: ContactListViewModelOutput { return self }
  
  // MARK: - INPUT
  var viewWillAppear: PublishRelay<Void>
  
  // MARK: - OUTPUT
  var activate: Driver<Bool>
  var contactList: Driver<[Contact]>
  
  
  // MARK: - Init
  
  init(fetchContactListUseCase: FetchContactListUseCase) {
    self.fetchContactListUseCase = fetchContactListUseCase
    
    var fetching = PublishRelay<Void>()
    var contacts = BehaviorRelay<[Contact]>(value: [])
    var activating = BehaviorRelay<Bool>(value: false)
  
    viewWillAppear = fetching
    activate = activating.asDriver(onErrorJustReturn: false)
    contactList = contacts.asDriver(onErrorJustReturn: [])
  }
}

