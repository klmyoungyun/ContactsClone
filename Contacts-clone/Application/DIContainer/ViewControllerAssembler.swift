//
//  ViewControllerAssembler.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import Swinject

final class ViewControllerAssembler: Assembly {
  func assemble(container: Container) {
    container.register(ContactListViewController.self) { (r,
                                                          viewModel: ContactListViewModel) in
      let viewController = ContactListViewController(viewModel: viewModel)
      return viewController
    }
    
    container.register(DetailContactViewController.self) { (r,
                                                            viewModel: DetailContactViewModel) in
      let viewController = DetailContactViewController(viewModel: viewModel)
      return viewController
    }
  }
}
