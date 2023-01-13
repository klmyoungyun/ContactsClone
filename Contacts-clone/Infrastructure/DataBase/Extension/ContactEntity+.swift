//
//  ContactEntity+.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import Foundation

extension ContactEntity {
  func toResponseDTO() -> ContactResponseDTO {
    return ContactResponseDTO(id: self.value(forKey: "id") as! UUID,
                              firstName: self.value(forKey: "firstName") as? String,
                              lastName: self.value(forKey: "lastName") as? String,
                              company: self.value(forKey: "company") as? String,
                              number: self.value(forKey: "number") as! String,
                              notes: self.value(forKey: "notes") as? String)
  }
}
