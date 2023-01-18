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
  func closeModal()
  func closeViewController()
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
    let viewModel = Assembler.shared.resolver.resolve(ContactListViewModel.self,
                                                      argument: self as ContactListCoordinator)!
    let viewController = Assembler.shared.resolver.resolve(ContactListViewController.self,
                                                           argument: viewModel)!
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func showDetailContactFlow(with contact: Contact) {
    let viewModel = Assembler.shared.resolver.resolve(DetailContactViewModel.self,
                                                      arguments: contact, self as ContactListCoordinator)!
    let viewController = Assembler.shared.resolver.resolve(DetailContactViewController.self,
                                                           argument: viewModel)!
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func createContactFlow() {
    let viewModel = Assembler.shared.resolver.resolve(CreateContactViewModel.self,
                                                      argument: self as ContactListCoordinator)!
    let viewController = Assembler.shared.resolver.resolve(CreateContactViewController.self,
                                                           argument: viewModel)!
    let navVC = UINavigationController(rootViewController: viewController)
    navigationController.present(navVC, animated: true)
  }
  
  func closeModal() {
    navigationController.dismiss(animated: false)
  }
     
  func closeViewController() {
    navigationController.popViewController(animated: true)
  }
}
