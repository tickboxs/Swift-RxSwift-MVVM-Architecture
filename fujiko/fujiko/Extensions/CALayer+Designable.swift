//
//  CALayer+Designable.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    var borderColorFromUIColor: UIColor {
        
        set {
            borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: borderColor!)
        }
    }

}
