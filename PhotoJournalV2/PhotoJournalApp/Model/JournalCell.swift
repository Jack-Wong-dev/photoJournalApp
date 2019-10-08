//
//  JournalCell.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/5/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class JournalCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var optionButtonLabel: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    
    func configureCell(journal : PhotoJournal, tag: Int){
        layer.cornerRadius = 12
        layer.borderWidth = 4
        captionLabel.text = journal.description
        print(journal.description)
        optionButtonLabel.tag = tag
        cellImage.image = UIImage(data: journal.imageData)
        timeStamp.text = journal.dateFormattedString
        print(timeStamp.text)
        print()
    }
}


