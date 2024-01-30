//
//  UserSettings.swift
//  Cocina
//
//  Created by Pedro on 30/1/24.
//

import Foundation

import Foundation

class UserSettings {
    static let shared = UserSettings()

    private let apiKeyKey = "SPOONACULAR_API_KEY"

    var apiKey: String? {
        get {
            return UserDefaults.standard.string(forKey: apiKeyKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: apiKeyKey)
        }
    }

    private init() {
    }
}
