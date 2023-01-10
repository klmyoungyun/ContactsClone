//
//  ContactCell.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import UIKit

class ContactCell: UITableViewCell {
  static let identifier = "ContactCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
