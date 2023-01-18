//
//  StackView+.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/17.
//

import UIKit

extension UIStackView {
  func addHorizontalSeparators() {
    // 1 2 3
    var i = self.arrangedSubviews.count - 1
    while i > 0 {
      let separator = UIView()
      separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
      separator.backgroundColor = UIColor.secondaryLabel
      self.insertArrangedSubview(separator, at: i)
      i -= 1
    }
  }
}
