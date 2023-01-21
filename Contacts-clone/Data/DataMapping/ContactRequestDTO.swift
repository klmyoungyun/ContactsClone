//
//  ContactRequestDTO.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/11.
//

import Foundation

struct ContactRequestDTO: Encodable {
  var id: UUID
  var information: InformationDTO
}

struct InformationDTO: Encodable {
  var firstName: String
  var lastName: String
  var company: String
  var number: String
  var notes: String
}
