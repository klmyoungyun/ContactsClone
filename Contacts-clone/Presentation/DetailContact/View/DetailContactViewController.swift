//
//  DetailContactViewController.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/12.
//

import UIKit

import RxCocoa
import RxSwift

final class DetailContactViewController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel: DetailContactViewModel
  
  private let deleteButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .cyan
    button.setTitle("delete", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  init(viewModel: DetailContactViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("DetailContactViewController init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setSubViews()
    setConstraints()
    bindViewModel()
  }
}

// MARK: - UI Functions

extension DetailContactViewController {
  func setNavigation() {
    navigationItem.rightBarButtonItem = editButtonItem
  }
  
  func setSubViews() {
    view.backgroundColor = .systemBackground
    view.addSubview(deleteButton)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      deleteButton.widthAnchor.constraint(equalToConstant: 100),
      deleteButton.heightAnchor.constraint(equalToConstant: 50),
      deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      deleteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}

// MARK: - Bind Functions

extension DetailContactViewController {
  func bindViewModel() {
    let input = DetailContactViewModel.Input(deleteTrigger: deleteButton.rx.tap.asSignal())
    let output = viewModel.transform(input: input)
    
    output.deleteContact
      .drive()
      .disposed(by: disposeBag)
  }  
}
