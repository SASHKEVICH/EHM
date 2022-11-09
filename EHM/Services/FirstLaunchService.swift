//
//  FirstLaunchService.swift
//  EHM
//
//  Created by Александр Бекренев on 09.11.2022.
//

import Foundation

class FirstLaunchService: FirstLaunchServiceProtocol {
    private let userDefaults = UserDefaults.standard
    private let key = "isAppAlreadyLaunchedOnce"
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        let launchCount = userDefaults.integer(forKey: key)
        if launchCount == 0 {
            print("App launched first time")
            userDefaults.set(launchCount + 1, forKey: key)
            return false
        } else {
            userDefaults.set(launchCount + 1, forKey: key)
            print("App already launched")
            return true
        }
    }
}
