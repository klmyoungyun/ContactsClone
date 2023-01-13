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
  typealias ResultObservable = Observable<Result<[Contact], Error>>
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
  func findAll() -> Observable<Result<[Contact], Error>>{
    let context = self.mainContext
    return ResultObservable.create { observer in
      let request = NSFetchRequest<NSManagedObject>(entityName: "ContactEntity")
      let sort = NSSortDescriptor(key: "firstName", ascending: true)
      request.sortDescriptors = [sort]
      do {
        let result = try context.fetch(request) as! [ContactEntity]
        let contactList = result.map { $0.toResponseDTO().toDomain() }
        
        observer.onNext(.success(contactList))
        observer.onCompleted()
      } catch {
        observer.onError(error)
      }
      return Disposables.create()
    }
  }
  
  func findById(_ id: UUID) {
    
  }
  
  func createContact(_ contactRequest: ContactRequestDTO) {
    
  }
  
  func deleteContact(_ id: UUID) {
    
  }
  
  func updateContact(id: UUID, contact: ContactRequestDTO) {
    
  }
  
  
}
