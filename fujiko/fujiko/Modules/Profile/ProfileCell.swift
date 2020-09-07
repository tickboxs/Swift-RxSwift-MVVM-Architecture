//
//  ProfileCell.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import Swinject
import RxBiBinding

final class ProfileCell: TableViewCell {
    
    @IBOutlet weak var topLabel: Label!
    @IBOutlet weak var centerLabel: Label!
    @IBOutlet weak var bottomLabel: Label!
    
    @IBOutlet weak var onSwitch: Switch!
    
    public var vm: ProfileCellViewModel? {
        didSet {
            
            if let topText = vm?.topText {
                topLabel.isHidden = false
                topLabel.text = topText
            } else { topLabel.isHidden = true }

            if let centerText = vm?.centerText {
                centerLabel.isHidden = false
                centerLabel.text = centerText
            } else { centerLabel.isHidden = true }
            
            if let bottomText = vm?.bottomText {
                bottomLabel.isHidden = false
                bottomLabel.text = bottomText
            } else { bottomLabel.isHidden = true }
            
            if let isSwitchOn = vm?.switchStatus {
                onSwitch.isHidden = false
                onSwitch.isOn = isSwitchOn
                
            } else { onSwitch.isHidden = true }
            
            // IMPORTANT!!!
            if let behaviorRelay = vm?.bibindRelay {
                (onSwitch.rx.controlProperty(editingEvents: .valueChanged,
                                             getter: { $0.isOn }) { $0.isOn = $1 } <-> behaviorRelay)
                    .disposed(by: self.rx.reuseBag)
            }
            
        }
    }
}
