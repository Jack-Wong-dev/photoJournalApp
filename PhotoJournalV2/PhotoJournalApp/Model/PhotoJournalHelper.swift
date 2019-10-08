//
//  File.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/7/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

class PhotoJournalHelper {
    
    public static let filename = "photoJournalDatabase.plist"
    
    private static var everyPhotoJournal = [PhotoJournal]()
    
    private init() {}
    
    static func saveEntry() {
        let path = PersistenceManager.filePathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(everyPhotoJournal)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list error: \(error)")
        }
    }
    
    static func retrievePhotoJournals() -> [PhotoJournal] {
        let path = PersistenceManager.filePathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    everyPhotoJournal = try PropertyListDecoder().decode([PhotoJournal].self, from: data).sorted(by: {$0.creationDate > $1.creationDate})
                } catch {
                    print("\(error)")
                }
            } else {
                print("nothing")
            }
        } else {
            print("The filename cannot be found")
        }
        return everyPhotoJournal
    }
    
    static func addPhotoJournal(photoJournal: PhotoJournal) {
        everyPhotoJournal.append(photoJournal)
        saveEntry()
    }
    
    static func editPhotoJournal(photoJournal: PhotoJournal, atIndex index: Int) {
       everyPhotoJournal[index] = photoJournal
       saveEntry()
       }
    
    static func deletePhoto(atIndex index: Int) {
        everyPhotoJournal.remove(at: index)
        saveEntry()
    }
    
   
}
