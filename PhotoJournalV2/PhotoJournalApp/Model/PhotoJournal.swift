//
//  PhotoJournal.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/5/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
    var imageData: Data
    var creationDate: String
    var description: String
    
    public var dateFormattedString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = creationDate
        if let date = isoDateFormatter.date(from: creationDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
}
