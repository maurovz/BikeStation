import Foundation
import CoreData

class PersistentContainer: NSPersistentContainer { } // Needs subclassing to be used in dynamic framework

class CoreDataStack {
  static var persistentContainer: PersistentContainer = {
    let container: PersistentContainer = {
        let result = PersistentContainer(name: "StationModel")
        result.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return result
    }()

    return container
  }()

  class func saveContext () {
    let context = CoreDataStack.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let _ = error as NSError
        return
      }
    }
  }
}
