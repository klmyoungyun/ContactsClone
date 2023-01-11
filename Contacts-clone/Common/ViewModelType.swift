//
//  ViewModelType.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/11.
//

import Foundation

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}
