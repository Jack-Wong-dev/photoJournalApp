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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setSegments()
    }
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeScrollDirection(_ sender: UISegmentedControl) {
        scrollDirection = sender.selectedSegmentIndex
        settingDelegate?.setUpScrolling()
    }
    
    @IBAction func changeBackgroundMode(_ sender: UISegmentedControl) {
        backgroundMode = sender.selectedSegmentIndex
        settingDelegate?.updateBackgroundMode()
    }
    
    func setSegments() {
        if let savedScrollDirection = UserDefaultsWrapper.shared.getScrollDirection() {
            scrollSegmentedControl.selectedSegmentIndex = savedScrollDirection
        }
       
        if let savedBackgroundMode = UserDefaultsWrapper.shared.getBackgroundMode() {
            colorModeSegmentedControl.selectedSegmentIndex = savedBackgroundMode
        }
    }
}



