//
//  SettingsUserDefaults.swift
//  PhotoJournalApp
//
//  Created by Jack Wong on 10/8/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    static let shared = UserDefaultsWrapper()
    
    func getScrollDirection() -> Int? {
        return UserDefaults.standard.value(forKey: scrollDirectionKey) as? Int
    }
    
    func getBackgroundMode() -> Int? {
        return UserDefaults.standard.value(forKey: darkModeKey) as? Int
    }
    
    func store(scrollDirection: Int) {
        UserDefaults.standard.set(scrollDirection, forKey: scrollDirectionKey)
    }
    
    func store(backgroundMode: Int) {
        UserDefaults.standard.set(backgroundMode, forKey: darkModeKey)
    }
    
    private let scrollDirectionKey = "scrollDirection"
    private let darkModeKey = "darkMode"
}
