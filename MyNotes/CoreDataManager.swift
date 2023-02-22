//
//  CoreDataManager.swift
//  NinjaNotes
//
//  Created by Arip Khozhbanov on 22.02.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "NinjaNotes")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
         persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else { fatalError(error!.localizedDescription) }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
}

extension CoreDataManager {
    func createNode() -> Note{
        let note = Note(context: viewContext)
        note.id = UUID()
        note.text = ""
        note.lastUpdated = Date()
        save()
        return note
    }
    
    func fetchNotes(_ filter: String? = nil) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteNode(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}
