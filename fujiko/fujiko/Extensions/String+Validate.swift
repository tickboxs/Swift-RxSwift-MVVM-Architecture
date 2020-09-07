//
//  String+Validate.swift
//  fujiko
//
//  Created by Charlie Cai on 10/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
