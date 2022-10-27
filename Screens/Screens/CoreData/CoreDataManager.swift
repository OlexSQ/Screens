//
//  CoreDataManager.swift
//  Screens
//
//  Created by Mac on 27.10.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "Screens")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        }
    }

    func createScreen(name: String, numberOfViews: Int32) {
        let screen = Screen(context: viewContext)
        screen.name = name
        screen.numberOfViews = numberOfViews
        save()
    }
    
    func fetchScreens(filter: String? = nil) -> [Screen] {
        let request: NSFetchRequest<Screen> = Screen.fetchRequest()
        if let filter = filter {
            let predicate = NSPredicate(format: "name == %@", filter)
            request.predicate = predicate
        }
        return (try? viewContext.fetch(request)) ?? []
    }
}
