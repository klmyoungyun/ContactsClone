//
//  Assember+.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import Foundation

import Swinject

extension Assembler {
  static let shared: Assembler = {
    let assembler = Assembler(
      [
        DataStorageAssembler(),
        RepositoryAssember(),
        UseCaseAssembler(),
        CoordinatorAssembler(),
        ViewModelAssembler(),
        ViewControllerAssembler()
      ],
      container: .init())
    return assembler
  }()
}
