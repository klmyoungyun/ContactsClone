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
  private let viewModel: CreateContactViewModel
  
  init(viewModel: CreateContactViewModel) {
    self.viewModel = viewModel
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
  
  private lazy var cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                  target: self,
                                                  action: nil)
  
  private lazy var doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                                target: self,
                                                action: nil)
  
  private let textfieldStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.backgroundColor = .white
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    stackView.layer.borderWidth = 0.2
    stackView.layer.borderColor = UIColor.secondaryLabel.cgColor
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let firstNameTextField = CustomTextField(placeholder: "First name")
  
  private let lastNameTextField = CustomTextField(placeholder: "Last name")
  
  private let companyNameTextField = CustomTextField(placeholder: "Company")
  
  private let numberTextField: CustomTextField = {
    let textfield = CustomTextField(placeholder: "Number")
    textfield.layer.borderWidth = 0.2
    textfield.layer.borderColor = UIColor.secondaryLabel.cgColor
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()
}

// MARK: - UI Functions

extension CreateContactViewController {
  func setNavigation() {
    navigationItem.leftBarButtonItem = cancelButton
    navigationItem.rightBarButtonItem = doneButton
  }
  
  func setSubViews() {
    view.backgroundColor = .secondarySystemBackground
    view.addSubview(textfieldStackView)
    [firstNameTextField,
     lastNameTextField,
     companyNameTextField].forEach {
      textfieldStackView.addArrangedSubview($0)
    }
    textfieldStackView.addHorizontalSeparators()
    view.addSubview(numberTextField)
  }
  
  func setConstraints() {
    firstNameTextField.setContentHuggingPriority(UILayoutPriority(750), for: .vertical)
    lastNameTextField.setContentHuggingPriority(UILayoutPriority(750), for: .vertical)
    companyNameTextField.setContentHuggingPriority(UILayoutPriority(750), for: .vertical)
    NSLayoutConstraint.activate([
      textfieldStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textfieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      textfieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      textfieldStackView.heightAnchor.constraint(equalToConstant: 151),
      numberTextField.topAnchor.constraint(equalTo: textfieldStackView.bottomAnchor, constant: 40),
      numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      numberTextField.heightAnchor.constraint(equalToConstant: 50)
      
      
    ])
  }
}

// MARK: - Bind functions

extension CreateContactViewController {
  func bindViewModel() {
    let firstName = firstNameTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: "")
    let lastName = lastNameTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: "")
    let company = companyNameTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: "")
    let number = numberTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: "")
    let input = CreateContactViewModel.Input(cancelTrigger: cancelButton.rx.tap.asSignal(),
                                             createTrigger: doneButton.rx.tap.asSignal(),
                                             firstName: firstName,
                                             lastName: lastName,
                                             company: company,
                                             number: number,
                                             note: Signal<String>.just(""))
    let output = viewModel.transform(input: input)
    
    output.title
      .drive(navigationItem.rx.title)
      .disposed(by: disposeBag)
    
    output.doneButtonCanTap
      .drive(doneButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
}
