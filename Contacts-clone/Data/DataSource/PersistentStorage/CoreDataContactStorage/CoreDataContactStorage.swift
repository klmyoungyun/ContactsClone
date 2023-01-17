//
//  CoreDataContactStorage.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import CoreData

import RxSwift

final class CoreDataContactStorage {
  typealias ContactListResultObservable = Observable<Result<[Contact], ErrorType>>
  typealias ContactResultObservable = Observable<Result<Contact, ErrorType>>
  
  private static let entityName = "ContactEntitiy"
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
        let contactList = result.map { $0.toResponseDTO().toDomain() }
        observer.onNext(.success(contactList))
      } catch {
        observer.onError(error)
      }
      return Disposables.create()
    }
  }
  
  func createContact(_ contact: Contact) -> ContactResultObservable {
    let context = coreDataStorage.backgroundContext
    let entity = NSEntityDescription.entity(forEntityName: CoreDataContactStorage.entityName,
                                            in: context)
    return ContactResultObservable.create { observer in
      if let entity = entity {
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(UUID(), forKey: "id")
        managedObject.setValue(contact.firstName, forKey: "firstName")
        managedObject.setValue(contact.lastName, forKey: "lastName")
        managedObject.setValue(contact.lastName, forKey: "lastName")
        managedObject.setValue(contact.number, forKey: "number")
        managedObject.setValue(contact.notes, forKey: "notes")
        do {
          try context.save()
          observer.onNext(.success(contact))
        } catch {
          observer.onNext(.failure(.coredataError))
        }
      }
      return Disposables.create()
    }
  }
  
  func deleteContact(for requestDTO: ContactRequestDTO) -> ContactResultObservable {
    let context = coreDataStorage.backgroundContext
    let request = fetchRequest(for: requestDTO)
    return Observable.create { observer in
      do {
        let contactList = try context.fetch(request)
        contactList.forEach { contact in
          context.delete(contact as NSManagedObject)
        }
        try context.save()
        observer.onNext(.success(contactList[0].toResponseDTO().toDomain()))
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
