//
//  iocContainer.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import Swinject

func buildContainer() -> Container {
  let container = Container()
  
  container.register(DefaultContactRepository.self) { _ in
    return DefaultContactRepository()
  }.inObjectScope(.container)
  
  container.register(DefaultFetchContactListUseCase.self) { resolver in
    let contactRepository = resolver.resolve(DefaultContactRepository.self)!
    return DefaultFetchContactListUseCase(contactRepository: contactRepository)
  }.inObjectScope(.container)
  
  container.register(ContactListViewModel.self) { resolver in
    let fetchContactListUseCase = resolver.resolve(DefaultFetchContactListUseCase.self)!
    return ContactListViewModel(fetchContactListUseCase: fetchContactListUseCase)
  }.inObjectScope(.container)
  
  return container
}
