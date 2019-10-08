//
//  DataPersistenceManager.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/5/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

class PersistenceManager {
    static func location() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func filePathToDocumentsDirectory(filename: String) -> URL {
      return location().appendingPathComponent(filename)
    }
}
