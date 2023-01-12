//
//  CoordinatorAssembler.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation
import UIKit

import Swinject

final class CoordinatorAssembler: Assembly {
  func assemble(container: Container) {
    container.register(AppCoordinator.self) { r, window in
      let appCoordinator = DefaultAppCoordinator(window: window)
      return appCoordinator
    }
    
    container.register(ContactListCoordinator.self) { r, nav in
      let contactListCoordinator = DefaultContactListCoordinator(nav)
      return contactListCoordinator
    }
  }
}
