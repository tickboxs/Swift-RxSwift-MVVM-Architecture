//
//  Button.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class Button: UIButton {
    
    @IBInspectable var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -titleLeftPadding, bottom: 0, right: titleLeftPadding)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: titleLeftPadding, bottom: 0, right: titleLeftPadding)
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

}
