//
//  Switch.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

@IBDesignable
class Switch: ZJSwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
        
    }
    
    private func makeUI() {
        textFont = UIFont(name: "Poppins-Medium", size: 12)
        onTextColor = .white
        offTextColor = .white
        onText = "ON"
        offText = "OFF"
        style = .noBorder
        onTintColor = UIColor(hexString: "#CDCDCD")
        tintColor = UIColor(hexString: "#2DD8CF")
        thumbTintColor = .white
    }
}
