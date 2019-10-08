//
//  EditViewController.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/5/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit


class EditViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    //Button Outlets
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var journalTextView: UITextView!
    
    private var imagePickerController : UIImagePickerController!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var selectedPhotoJournal: PhotoJournal?
    var index: Int?
    var isEditView: Bool!
    
    private var placeholderText = "Enter description here..."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalTextView.delegate = self
        //        journalTextView.becomeFirstResponder()
        
        imagePickerView()
        if let photo = selectedPhotoJournal {
            photoImage.image = UIImage.init(data: photo.imageData)
            journalTextView.text = photo.description
        }else{
            journalTextView.text = placeholderText
            journalTextView.textColor = .lightGray
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapRecognizer(_ sender: UITapGestureRecognizer) {
        journalTextView.resignFirstResponder()
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        guard let titletextview = journalTextView.text else { return }
        
        if selectedPhotoJournal != nil {
            if let imageData = photoImage.image?.jpegData(compressionQuality: 0.5) {
                let newPhotoJournal = PhotoJournal.init(imageData: imageData, creationDate: setTimeStamp(), description: journalTextView.text)
                PhotoJournalHelper.editPhotoJournal(photoJournal: newPhotoJournal, atIndex: index!)
                dismiss(animated: true, completion: nil)
            }
        }else {
            
            if let imageData = photoImage.image?.jpegData(compressionQuality: 0.5) {
                let photo = PhotoJournal.init(imageData: imageData, creationDate: setTimeStamp(), description: titletextview)
                PhotoJournalHelper.addPhotoJournal(photoJournal: photo)
                dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    private func setTimeStamp() -> String{
        let newDate = Date()
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate,
                                       .withFullTime,
                                       .withInternetDateTime]
        let timeStamp = dateFormatter.string(from: newDate)
        return timeStamp
    }
    
    
    @IBAction func photoLibraryPressed(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .photoLibrary
        showImageController()
    }
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .camera
        showImageController()
    }
    
    
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private func imagePickerView() {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
    }
    
    private func showImageController() {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImage.image = image
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension EditViewController: UITextViewDelegate{
    
    //This should remove the placeholder text
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText{
            journalTextView.text =  ""
            journalTextView.textColor = .black
        }
    }
}
