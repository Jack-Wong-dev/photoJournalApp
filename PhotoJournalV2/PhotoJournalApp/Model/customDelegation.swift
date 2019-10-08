import UIKit
import Foundation

protocol SettingsDelegate: AnyObject {
    func updateBackgroundMode()
    func loadSettings()
    func loadTextColor()
}
