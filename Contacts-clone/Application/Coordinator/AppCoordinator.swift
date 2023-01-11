//
//  AppCoordinator.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import UIKit

final class AppCoordinator: Coordinator {
  var finishDelegate: CoordinatorFinishDelegate?
  
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var type: CoordinatorType = .app
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    showContactListFlow()
  }

  private func showContactListFlow() {
    let contactListCoordinator = ContactListCoordinator(navigationController)
    contactListCoordinator.finishDelegate = self
    contactListCoordinator.start()
    childCoordinators.append(contactListCoordinator)
  }
}

extension AppCoordinator: CoordinatorFinishDelegate {
  func coordinatorDidFinish(childCoordinator: Coordinator) {
    print("\(self.type) has finished.")
    self.childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    self.navigationController.viewControllers.removeAll()
  }
}
