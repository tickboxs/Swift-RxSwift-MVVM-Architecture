//
//  TextField.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
        
    }
    
    private func makeUI() {
        
    }
    
    @IBInspectable var placeholderColor: UIColor = .gray {
        didSet {
            let str = NSAttributedString(
                string: placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
            attributedPlaceholder = str
        }
    }
    
}
