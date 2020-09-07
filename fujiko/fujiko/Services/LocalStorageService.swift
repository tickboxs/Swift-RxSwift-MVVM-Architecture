//
//  LocalStorageService.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocalStorageService: NSObject, ILocalStorageService {
    
    func setValueFor<T>(key: String, value: T) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValueFor(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    func isKeyExist(key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) != nil
    }
    
    func removeValueFor(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
