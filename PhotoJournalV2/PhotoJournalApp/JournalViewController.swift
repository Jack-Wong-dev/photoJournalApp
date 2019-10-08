//
//  ViewController.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/5/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit
import AVFoundation

class JournalViewController: UIViewController {
    
    @IBOutlet weak var journalCollectionView: UICollectionView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //Most recent posts goes appears first
    private var storedPhotoJournals = PhotoJournalHelper.retrievePhotoJournals(){
        didSet{
            self.journalCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalCollectionView.dataSource = self
        journalCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storedPhotoJournals = PhotoJournalHelper.retrievePhotoJournals()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "editController") as? EditViewController else { return }
        vc.modalPresentationStyle = .currentContext
        self.present(vc, animated: true, completion: nil)
        vc.isEditView = false
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Options", message: "Pick something!", preferredStyle: .actionSheet)
        
        //Edit
        let edit = UIAlertAction(title: "Edit", style: .default){_ in
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "editController") as? EditViewController else { return }
            let chosenPhotoJournal = PhotoJournalHelper.retrievePhotoJournals()[sender.tag]
            let photoIndex = sender.tag
            vc.selectedPhotoJournal = chosenPhotoJournal
            vc.index = photoIndex
            vc.isEditView = true
            vc.modalPresentationStyle = .currentContext
            self.present(vc, animated: true, completion: nil)
        }
        
        
        //Share
        let share = UIAlertAction(title: "Share", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            if let image = UIImage(data: self.storedPhotoJournals[sender.tag].imageData) {
                let shareText = self.storedPhotoJournals[sender.tag].description
                let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
                self.present(vc, animated: true, completion: nil)
            }
        })
        
        //Delete
        let delete = UIAlertAction(title: "Delete", style: .destructive){_ in
            PhotoJournalHelper.deletePhoto(atIndex: sender.tag)
            self.storedPhotoJournals  = PhotoJournalHelper.retrievePhotoJournals()
        }
        
        
        //Cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(share)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension JournalViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(storedPhotoJournals.count)
        return storedPhotoJournals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jCell", for: indexPath) as? JournalCell else { return UICollectionViewCell() }
        let somePhotoJournal = storedPhotoJournals[indexPath.row]
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 4
        cell.captionLabel.text = somePhotoJournal.description
        print(somePhotoJournal.description)
        cell.optionButtonLabel.tag = indexPath.row
        cell.cellImage.image = UIImage(data: somePhotoJournal.imageData)
        cell.timeStamp.text = somePhotoJournal.dateFormattedString
        print(cell.timeStamp.text)
        print()
        
        
        return cell
    }
    
    
}


