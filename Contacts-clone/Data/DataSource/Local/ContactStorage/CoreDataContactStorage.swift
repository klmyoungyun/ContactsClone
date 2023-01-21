//
//  CoreDataContactStorage.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import CoreData
import Foundation

import RxSwift

final class CoreDataContactStorage {
  typealias ContactListResultObservable = Observable<Result<[ContactResponseDTO], ErrorType>>
  typealias ContactResultObservable = Observable<Result<ContactResponseDTO, ErrorType>>
  typealias ContactEmptyResultObservable = Observable<Result<Void, ErrorType>>
  
  private static let entityName = "ContactEntity"
  private let coreDataStorage: CoreDataStorage
  
  init(coreDataStorage: CoreDataStorage) {
    self.coreDataStorage = coreDataStorage
  }
  
  private func fetchRequest(for requestDTO: ContactRequestDTO) -> NSFetchRequest<ContactEntity> {
    let request = ContactEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", requestDTO.id as CVarArg)
    return request
  }
}

extension CoreDataContactStorage: ContactStorage {
  func findAll() -> ContactListResultObservable {
    return ContactListResultObservable.create { observer in
      let request: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
      let sort = NSSortDescriptor(key: "firstName", ascending: true)
      request.sortDescriptors = [sort]
      do {
        let result = try self.coreDataStorage.backgroundContext.fetch(request)
        let contactResponse = result.map { $0.toResponseDTO() }
        observer.onNext(.success(contactResponse))
      } catch {
        observer.onError(error)
      }
      return Disposables.create()
    }
  }
  
  func createContact(_ information: Information) -> ContactResultObservable {
    let context = coreDataStorage.backgroundContext
    return ContactResultObservable.create { observer in
      
      let contact = ContactEntity(context: context)
      let id = UUID()
      contact.id = id
      contact.firstName = information.firstName
      contact.lastName = information.lastName
      contact.number = information.number
      contact.notes = information.notes
      contact.company = information.company
      do {
        try context.save()
        // 바꿔야함
        observer.onNext(.success(ContactResponseDTO(id: id,
                                                    firstName: information.firstName,
                                                    lastName: information.lastName,
                                                    company: information.company,
                                                    number: information.number,
                                                    notes: information.notes)))
      } catch {
        observer.onNext(.failure(.coredataError))
      }
      return Disposables.create()
    }
  }
  
  func deleteContact(for requestDTO: ContactRequestDTO) -> ContactEmptyResultObservable {
    let context = coreDataStorage.backgroundContext
    let request = fetchRequest(for: requestDTO)
    return Observable.create { observer in
      do {
        let contactList = try context.fetch(request)
        if let contact = contactList.first {
          context.delete(contact)
          try context.save()
          observer.onNext(.success(()))
        }
      } catch {
        observer.onNext(.failure(.coredataError))
      }
      return Disposables.create()
    }
  }
  
  func updateContact(for requestDTO: ContactRequestDTO) -> ContactResultObservable {
    let context = coreDataStorage.backgroundContext
    let request = fetchRequest(for: requestDTO)
    let information = requestDTO.information
    return Observable.create { observer in
      do {
        if let contact = try context.fetch(request).first {
          contact.firstName = information.firstName
          contact.lastName = information.lastName
          contact.number = information.number
          contact.number = information.number
          contact.company = information.company
          try context.save()
        }
      } catch {
        observer.onNext(.failure(.coredataError))
      }
      return Disposables.create()
    }
  }
}
