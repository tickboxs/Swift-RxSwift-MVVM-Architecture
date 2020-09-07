//
//  PercentagePropertyWrapper.swift
//  fujiko
//
//  Created by Charlie Cai on 26/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

@propertyWrapper
struct PercentagePW {
    private var percentage: Float?
    init() {
        self.percentage = 0
    }
    init(percentage: Float) {
        self.percentage = percentage
    }
    var wrappedValue: Float? {
        get { return percentage }
        set {
            if let value = newValue {
                if value < 0 {
                    percentage = 0
                    Logger.log("Found Percentage Value < 0, Actual Value is \(value)", .debug)
                } else if value > 1 {
                    percentage = 1
                    Logger.log("Found Percentage Value > 1, Actual Value is \(value)", .debug)
                } else {
                    percentage = value
                }
            }
        }
    }
}
