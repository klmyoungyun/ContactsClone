//
//  CreateContactViewController.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import UIKit

import RxCocoa
import RxSwift

final class CreateContactViewController: UIViewController {
  private let disposeBag = DisposeBag()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("CreateContactViewController init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setSubViews()
    setConstraints()
    bindViewModel()
  }
  
  // MARK: - UI
  
  private lazy var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .cancel,
                                 target: self,
                                 action: nil)
    return button
  }()
}

// MARK: - UI Functions

extension CreateContactViewController {
  func setNavigation() {
    
  }
  
  func setSubViews() { }
  
  func setConstraints() { }
}

// MARK: - Bind functions

extension CreateContactViewController {
  func bindViewModel() { }
  
}
