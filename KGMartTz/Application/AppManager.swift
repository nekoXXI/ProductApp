//
//  AppManager.swift
//  KGMartTz
//
//  Created by Адиль on 4/5/24.
//

import Foundation
import SwiftUI

final class AppManager {
    private static let userDefaults = UserDefaults.standard
    
    static var authToken: String? {
        get {
            userDefaults.string(forKey: "authToken")
        } set {
            userDefaults.setValue(newValue, forKey: "authToken")
        }
    }
}

