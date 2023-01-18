//
//  ContactCell.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import UIKit

final class ContactCell: UITableViewCell {
  static let identifier = "ContactCell"
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setNameLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = ""
  }
}

extension ContactCell {
  private func setNameLabel() {
    addSubview(nameLabel)
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
      nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
  func bind(with contact: Contact) {
    let firstName = contact.information.firstName
    let lastName = contact.information.lastName
    nameLabel.text = firstName + lastName
  }
}
