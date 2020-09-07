//
//  EmailPropertyWrapper.swift
//  fujiko
//
//  Created by Charlie Cai on 27/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

@propertyWrapper
struct EmailPW {
    private var email: String
    init() {
        self.email = ""
    }
    init(email: String) {
        self.email = email
    }
    var wrappedValue: String? {
        get { return email }
        set {
            if let value = newValue {
                if !value.isValidEmail() {
                    Logger.log("Found Email Invalid please check with backend Team, Actual Value is \(value)",.debug)
                }
                email = value

            }
        }
    }
}
