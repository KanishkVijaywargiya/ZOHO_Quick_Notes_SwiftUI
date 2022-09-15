//
//  CoreDataViewModel.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 15/09/22.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var savedEntities: [NoteEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "NotesContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data \(error.localizedDescription)")
            }
        }
        fetchNotes()
    }
    
    func fetchNotes() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error in fetching. \(error.localizedDescription)")
        }
    }
    
    func addNote(title: String, body: String, imageURL: Data) {
        let newNote = NoteEntity(context: container.viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.body = body
        newNote.imageURL = imageURL
        newNote.createdTime = Int16(String(format: "%.0f", NSDate().timeIntervalSince1970)) ?? Int16()
//        newNote.createdTime = NSDate().timeIntervalSince1970
        saveNote()
    }
    
    func saveNote() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
            }
        } catch let error {
            print("Error in saving. \(error.localizedDescription)")
            container.viewContext.rollback()
        }
        fetchNotes()
    }
}

