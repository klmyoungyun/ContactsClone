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
  private let viewModel: ContactListViewModel
  
  init(viewModel: ContactListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("ContactListViewController init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setSubViews()
    setConstraints()
    bindViewModel()
    bindContactListView()
  }
  
  // MARK: - UI
  
  private lazy var createButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                  style: .plain,
                                                  target: self,
                                                  action: nil)
  
  private let searchController: UISearchController = {
    let controller = UISearchController(searchResultsController: nil)
    controller.hidesNavigationBarDuringPresentation = true
    return controller
  }()
  
  private lazy var contactListView: UITableView = {
    let tableView = UITableView()
    tableView.refreshControl = UIRefreshControl()
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.rowHeight = 44
    tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
    return tableView
  }()
}

// MARK: - UI Functions

private extension ContactListViewController {
  func setNavigation() {
    navigationItem.rightBarButtonItem = createButton
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  func setSubViews() {
    view.backgroundColor = .systemBackground
    view.addSubview(contactListView)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      contactListView.topAnchor.constraint(equalTo: view.topAnchor),
      contactListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contactListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      contactListView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}

// MARK: - Bind Functions

private extension ContactListViewController {
  func bindViewModel() {
    // INPUT
    let viewWillAppear = rx.viewWillAppear
      .asSignal()
    
    let pull = contactListView.refreshControl!.rx
      .controlEvent(.valueChanged)
      .asSignal()
    
    let showDetailContact = contactListView.rx.modelSelected(Contact.self).asSignal()
      
    let input = ContactListViewModel.Input(trigger: Signal.merge(viewWillAppear, pull),
                                           showDetailContactTrigger: showDetailContact,
                                           createContactTrigger: createButton.rx.tap.asSignal())
    // OUTPUT
    let output = viewModel.transform(input: input)
    
    output.title
      .drive(navigationItem.rx.title)
      .disposed(by: disposeBag)
    
    output.contactList
      .drive(contactListView.rx.items(cellIdentifier: ContactCell.identifier,
                                           cellType: ContactCell.self)) { row, contact, cell in
        cell.bind(with: contact)
      }
      .disposed(by: disposeBag)
    
    output.fetching
      .drive(contactListView.refreshControl!.rx.isRefreshing)
      .disposed(by: disposeBag)
    
    output.createContact
      .drive()
      .disposed(by: disposeBag)
    
    output.showDetailContact
      .drive()
      .disposed(by: disposeBag)
  }
  
  func bindContactListView() {
    Observable.zip(contactListView.rx.modelSelected(Contact.self),
               contactListView.rx.itemSelected)
    .bind(onNext: { [weak self] contact, indexPath in
      guard let self = self else { return }
      self.contactListView.deselectRow(at: indexPath, animated: true)
    })
    .disposed(by: disposeBag)
  }
}

