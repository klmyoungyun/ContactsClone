//
//  CustomTextField.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/16.
//

import UIKit

class CustomTextField: UITextField {
  init(placeholder: String, frame: CGRect = .zero) {
    super.init(frame: frame)
    setUI()
    self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                    attributes: [.foregroundColor: UIColor.secondaryLabel])
    
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CustomTextField {
  func setUI() {
    self.backgroundColor = .white
    self.clearButtonMode = .whileEditing
  }
}


