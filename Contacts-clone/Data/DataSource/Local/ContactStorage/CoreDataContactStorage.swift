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
      let request = NSFetchRequest<NSManagedObject>(entityName: CoreDataContactStorage.entityName)
      let sort = NSSortDescriptor(key: "firstName", ascending: true)
      request.sortDescriptors = [sort]
      do {
        let result = try self.coreDataStorage.backgroundContext.fetch(request) as! [ContactEntity]
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
    let entity = NSEntityDescription.entity(forEntityName: CoreDataContactStorage.entityName,
                                            in: context)
    return ContactResultObservable.create { observer in
      if let entity = entity {
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        let id = UUID()
        managedObject.setValue(id, forKey: "id")
        managedObject.setValue(information.firstName, forKey: "firstName")
        managedObject.setValue(information.lastName, forKey: "lastName")
        managedObject.setValue(information.lastName, forKey: "lastName")
        managedObject.setValue(information.number, forKey: "number")
        managedObject.setValue(information.notes, forKey: "notes")
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
          context.delete(contact as NSManagedObject)
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
    return Observable.create { observer in
      return Disposables.create()
    }
  }
}
