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
    
    var colorMode: UIColor!
    var fontColor: UIColor!
    
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
        setUpScrolling()
        
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "settingsController") as! SettingsViewController
        settingsVC.modalPresentationStyle = .currentContext
        
        settingsVC.settingDelegate = self
        
        present(settingsVC, animated: true, completion: .none)
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
                let sharedText = self.storedPhotoJournals[sender.tag].description
                let vc = UIActivityViewController(activityItems: [sharedText, image], applicationActivities: [])
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
        
        cell.configureCell(journal: somePhotoJournal, tag: indexPath.row)
        cell.backgroundColor = colorMode
        cell.captionLabel.textColor = fontColor
        cell.timeStamp.textColor = fontColor
        
        return cell
    }
    
    
}


extension JournalViewController: SettingsDelegate{
    
    func updateBackgroundMode(){
        
        guard let defaultBackgroundColor = UserDefaultsWrapper.shared.getBackgroundMode() else {
            
            colorMode = .white
            fontColor = .black
            
            return
        }
        
        colorMode = defaultBackgroundColor == 0 ? .white : .black
        fontColor = defaultBackgroundColor == 0 ? .black : .white
        
        journalCollectionView.reloadData()
    }
    
    func setUpScrolling() {
        if let defaultDirection = UserDefaultsWrapper.shared.getScrollDirection() {
            let currentDirection = defaultDirection == 0 ? UICollectionView.ScrollDirection.vertical : UICollectionView.ScrollDirection.horizontal
            
            if let collectionLayout = journalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                collectionLayout.scrollDirection = currentDirection
            }
        }
    }
    
}

