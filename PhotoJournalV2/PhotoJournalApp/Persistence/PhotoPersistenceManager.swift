//
//  PhotoJournalPersistence.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/7/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

struct EntryPersistenceHelper {
    
    private init() {}
    static let manager = EntryPersistenceHelper()
    
    private let persistenceHelper = PersistenceHelper<PhotoJournal>(fileName: "journal.plist")
    
    func saveEntry(entry: PhotoJournal) throws {
        try persistenceHelper.save(newElement: entry)
    }
    
    func getEntries() throws -> [PhotoJournal] {
        return try persistenceHelper.getObjects()
    }
    
    func deleteFavorite(withID: String) throws {
        do {
            let entries = try getEntries()
            let newEntries = entries.filter { $0.id != withID}
            try persistenceHelper.replace(elements: newEntries)
        }
    }
    
    func editEntry(editEntry: PhotoJournal, index: Int) throws {
        do {
            try persistenceHelper.update(updatedElement: editEntry, index: index)
        } catch {
            print(error)
        }
        
    }
    
}

