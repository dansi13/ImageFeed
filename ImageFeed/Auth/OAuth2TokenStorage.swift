//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Daniil Sivachenko on 19.10.2026.
//

import Foundation

final class OAuth2TokenStorage {
    private let userDefaults = UserDefaults.standard
    
    private enum Keys {
        static let token = "bearerToken"
    }
    
    var token: String? {
        get {
            userDefaults.string(forKey: Keys.token)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.token)
        }
    }
}
