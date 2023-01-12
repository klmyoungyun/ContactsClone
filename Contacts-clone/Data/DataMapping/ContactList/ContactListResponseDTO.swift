//
//  ContactListResponseDTO.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/11.
//

import Foundation

struct ContactListResponseDTO: Decodable {
  var contactList: [ContactDTO]
}

extension ContactListResponseDTO {
  struct ContactDTO: Decodable {
    var id: UUID
    var firstName: String?
    var lastName: String?
    var company: String?
    var number: String
  }
}

// MARK: - Mappings to Domain

extension ContactListResponseDTO {
  func toDomain() -> [Contact] {
    return contactList.map { .init(id: $0.id,
                                   firstName: $0.firstName,
                                   lastName: $0.lastName,
                                   company: $0.company,
                                   number: $0.number) }
  }
}
