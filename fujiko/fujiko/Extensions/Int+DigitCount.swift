//
//  Int+DigitCount.swift
//  fujiko
//
//  Created by Charlie Cai on 27/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

extension Int {
    func numberOfDigits() -> Int {
        if self < 10 && self >= 0 || self > -10 && self < 0 {
            return 1
        } else {
            return 1 + (self/10).numberOfDigits()
        }
    }
}
