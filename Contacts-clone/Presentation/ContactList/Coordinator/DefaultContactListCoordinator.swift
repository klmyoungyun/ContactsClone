//
//  ContactListCoordinator.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import UIKit

import Swinject

protocol ContactListCoordinator: Coordinator {
  func showDetailContactFlow(with contact: Contact)
  func createContactFlow()
}

final class DefaultContactListCoordinator: ContactListCoordinator {
  var finishDelegate: CoordinatorFinishDelegate?
  
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var type: CoordinatorType = .list
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.navigationController.navigationBar.prefersLargeTitles = true
  }
  
  func start() {
    let viewModel = Assembler.shared.resolver.resolve(ContactListViewModel.self, argument: self as ContactListCoordinator)!
    let viewController = Assembler.shared.resolver.resolve(ContactListViewController.self,
                                                           argument: viewModel)!
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func showDetailContactFlow(with contact: Contact) {
    let viewModel = Assembler.shared.resolver.resolve(DetailContactViewModel.self,
                                                      argument: contact)!
    let viewController = Assembler.shared.resolver.resolve(DetailContactViewController.self,
                                                           argument: viewModel)!
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func createContactFlow() {
    
  }
}

extension DefaultContactListCoordinator: CoordinatorFinishDelegate {
  func coordinatorDidFinish(childCoordinator: Coordinator) {
    childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    navigationController.viewControllers.removeAll()
    switch childCoordinator.type {
    case .detail:
      break
    default:
      break
    }
  }
}
