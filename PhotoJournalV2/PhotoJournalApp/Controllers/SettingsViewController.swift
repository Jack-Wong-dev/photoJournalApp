//
//  SettingsViewController.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/7/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var scrollSegmentedControl: UISegmentedControl!
    @IBOutlet weak var colorModeSegmentedControl: UISegmentedControl!
    
    var settingDelegate: SettingsDelegate?
    var scrollDirection = 0 {
        didSet {
            UserDefaultsWrapper.shared.store(scrollDirection: scrollDirection)
        }
    }
    
    var backgroundMode = 0 {
        didSet {
            UserDefaultsWrapper.shared.store(backgroundMode: backgroundMode)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegments()
//        setBackgroundModeForView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setSegments()
//        setBackgroundModeForView()
    }
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeScrollDirection(_ sender: UISegmentedControl) {
        scrollDirection = sender.selectedSegmentIndex
        settingDelegate?.loadSettings()
    }
    
    @IBAction func changeBackgroundMode(_ sender: UISegmentedControl) {
        backgroundMode = sender.selectedSegmentIndex
//        setBackgroundModeForView()
        settingDelegate?.loadSettings()
    }
    
    func setSegments() {
        if let savedScrollDirection = UserDefaultsWrapper.shared.getScrollDirection() {
            scrollSegmentedControl.selectedSegmentIndex = savedScrollDirection
        }
       
        if let savedBackgroundMode = UserDefaultsWrapper.shared.getBackgroundMode() {
            colorModeSegmentedControl.selectedSegmentIndex = savedBackgroundMode
        }
    }
//
//    private func setBackgroundModeForView() {
//        guard  let savedBackgroundMode = UserDefaultsWrapper.shared.getBackgroundMode() else {return}
//        let textColor = savedBackgroundMode == 0 ? UIColor.black : UIColor.white
//        let settingsColor = savedBackgroundMode == 0 ? UIColor.systemBlue : UIColor.white
//        let backgroundColor = savedBackgroundMode == 0 ? UIColor.groupTableViewBackground : UIColor.darkGray
//        let segmentColor = savedBackgroundMode == 0 ? UIColor.groupTableViewBackground : UIColor.darkGray
//
//        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
//        scrollDirectionSegment.setTitleTextAttributes(titleTextAttributes, for: .normal)
//        BackgroundModeSegment.setTitleTextAttributes(titleTextAttributes, for: .normal)
//        scrollDirectionSegment.backgroundColor = segmentColor
//        BackgroundModeSegment.backgroundColor = segmentColor
//        scrollLabel.textColor = textColor
//        backgroundLabel.textColor = textColor
//        settingsLabel.textColor = settingsColor
//        self.view.backgroundColor = backgroundColor
//    }
}



