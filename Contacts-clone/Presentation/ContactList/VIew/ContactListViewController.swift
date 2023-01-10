//
//  ContactListViewController.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/09.
//

import UIKit

import RxCocoa
import RxSwift

final class ContactListViewController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel: ContactListViewModelType
  
  private let contactListView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.backgroundColor = .blue
    return tableView
  }()
  
  init(viewModel: ContactListViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("ContactListViewController init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setSubViews()
    setConstraints()
    bind()
  }
}

// MARK: - UI Functions
extension ContactListViewController {
  func setSubViews() {
    view.backgroundColor = .systemBackground
    // view.addSubview(contactListView)
  }
  
  func setConstraints() {
    
  }
}

// MARK: - Bind Functions
extension ContactListViewController {
  func bind() {
    bindLifeCycle()
  }
  
  func bindLifeCycle() {
    rx.viewWillAppear
      .bind(to: viewModel.input.viewWillAppear)
      .disposed(by: disposeBag)
  }
}

