//
//  UnixTimestampPropertyWrapper.swift
//  fujiko
//
//  Created by Charlie Cai on 27/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

@propertyWrapper
struct UnixTimestampPW {
    private var timestamp: TimeInterval?
    init() {
        self.timestamp = 0
    }
    init(timestamp: TimeInterval) {
        self.timestamp = timestamp
    }
    var wrappedValue: TimeInterval? {
        get { return timestamp }
        set {
            if let value = newValue {
                if Int(value).numberOfDigits() != 13 {
                    
                }
                
                timestamp = value
            }
        }
    }
}

//Logger.log("Found Percentage Value < 0, Actual Value is \(value)",.debug)
