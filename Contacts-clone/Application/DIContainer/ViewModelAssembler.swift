//
//  ViewModelAssembler.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import Swinject

final class ViewModelAssembler: Assembly {
  func assemble(container: Container) {
    container.register(ContactListViewModel.self) { (r, coordinator: ContactListCoordinator) in
      let useCase = r.resolve(FetchContactListUseCase.self)!
      let viewModel = ContactListViewModel(fetchContactListUseCase: useCase,
                                           coordinator: coordinator)
      return viewModel
    }
    
    container.register(DetailContactViewModel.self) { (r,
                                                       contact: Contact) in
      let viewModel = DetailContactViewModel(contact: contact)
      return viewModel
    }
  }
}
