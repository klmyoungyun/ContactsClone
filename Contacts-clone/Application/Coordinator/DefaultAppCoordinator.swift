//
//  AppCoordinator.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import UIKit

import Swinject

protocol AppCoordinator: Coordinator {
  var window: UIWindow { get set }
}

final class DefaultAppCoordinator: AppCoordinator {
  var finishDelegate: CoordinatorFinishDelegate?

  var window: UIWindow
  
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var type: CoordinatorType = .app
  
  init(window: UIWindow,
       navigationController: UINavigationController = UINavigationController()) {
    self.window = window
    self.navigationController = navigationController
  }
  
  func start() {
    window.makeKeyAndVisible()
    window.rootViewController = navigationController
    let coordinator = Assembler.shared.resolver.resolve(ContactListCoordinator.self,
                                                                   argument: navigationController)!
    coordinator.finishDelegate = self
    coordinator.start()
    childCoordinators.append(coordinator)
  }
}

extension DefaultAppCoordinator: CoordinatorFinishDelegate {
  func coordinatorDidFinish(childCoordinator: Coordinator) {
    print("\(self.type) has finished.")
    self.childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
    self.navigationController.viewControllers.removeAll()
  }
}
