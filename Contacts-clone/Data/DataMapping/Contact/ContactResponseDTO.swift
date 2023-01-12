//
//  ContactResponseDTO.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/11.
//

import Foundation

struct ContactResponseDTO: Decodable {
  var id: UUID
  var firstName: String?
  var lastName: String?
  var company: String?
  var number: String
}

extension ContactResponseDTO {
  func toDomain() -> Contact {
    return .init(id: id,
                 firstName: firstName,
                 lastName: lastName,
                 company: company,
                 number: number)
  }
}
