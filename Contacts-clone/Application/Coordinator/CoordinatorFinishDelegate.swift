//
//  CoordinatorFinishDelegate.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
  func coordinatorDidFinish(childCoordinator: Coordinator)
}
