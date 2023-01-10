//
//  ContactListCoordinator.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import UIKit

final class ContactListCoordinator: Coordinator {
  var finishDelegate: CoordinatorFinishDelegate?
  
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var type: CoordinatorType = .list
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    showContactListFlow()
  }
  
  private func showContactListFlow() {
    let contactListViewModel = Resolver.shared.resolve(ContactListViewModel.self)
    let contactListViewController = ContactListViewController(viewModel: contactListViewModel)
    navigationController.viewControllers = [contactListViewController]
  }
}
