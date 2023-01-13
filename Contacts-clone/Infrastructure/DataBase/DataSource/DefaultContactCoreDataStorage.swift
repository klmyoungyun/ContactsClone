//
//  DefaultContactCoreDataStorage.swift
//  Contacts-clone
//
//  Created by 김영균 on 2023/01/13.
//

import CoreData
import Foundation

import RxSwift

final class DefaultContactCoreDataStorage: ContactCoreDataStorage {
  typealias ContactListResultObservable = Observable<Result<[Contact], Error>>
  typealias ContactResultObservable = Observable<Result<Contact, Error>>
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ContactEntity")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  private var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  init() { }
  
  @discardableResult
  func findAll() -> ContactListResultObservable {
    return ContactListResultObservable.create { observer in
      let request = NSFetchRequest<NSManagedObject>(entityName: "ContactEntity")
      let sort = NSSortDescriptor(key: "firstName", ascending: true)
      request.sortDescriptors = [sort]
      do {
        let result = try self.mainContext.fetch(request) as! [ContactEntity]
        let contactList = result.map { $0.toResponseDTO().toDomain() }
        
        observer.onNext(.success(contactList))
      } catch {
        observer.onError(error)
      }
      observer.onCompleted()
      return Disposables.create()
    }
  }
  
  func findById(_ id: UUID) {
    
  }
  
  func createContact(_ contact: Contact) -> ContactResultObservable {
    let entity = NSEntityDescription.entity(forEntityName: "ContactEntity",
                                            in: self.mainContext)
    return ContactResultObservable.create { observer in
      if let entity = entity {
        let managedObject = NSManagedObject(entity: entity, insertInto: self.mainContext)
        managedObject.setValue(contact.id, forKey: "id")
        managedObject.setValue(contact.firstName, forKey: "firstName")
        managedObject.setValue(contact.lastName, forKey: "lastName")
        managedObject.setValue(contact.lastName, forKey: "lastName")
        managedObject.setValue(contact.number, forKey: "number")
        managedObject.setValue(contact.notes, forKey: "notes")
        do {
          try self.mainContext.save()
          observer.onNext(.success(contact))
        } catch {
          observer.onNext(.failure(error))
        }
      }
      observer.onCompleted()
      return Disposables.create()
    }
  }
  
  func deleteContact(_ id: UUID) {
    
  }
  
  func updateContact(id: UUID, contact: ContactRequestDTO) {
    
  }
}
