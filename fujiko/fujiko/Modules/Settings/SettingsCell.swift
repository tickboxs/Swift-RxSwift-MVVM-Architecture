//
//  SettingsCell.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBiBinding

final class SettingsCell: TableViewCell {
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var onSwitch: Switch!
    
    public var vm: SettingsCellViewModel? {
        didSet {
            
            titleLabel.text = vm?.title
            // onSwitch hidden when vm.on is nil
            onSwitch.isHidden = vm?.on == nil
            onSwitch.isOn = vm?.on ?? false
            
            if let behaviorRelay = vm?.bibindingRelay {
                (onSwitch.rx.controlProperty(editingEvents: .valueChanged,
                                             getter: { $0.isOn }) { $0.isOn = $1 } <-> behaviorRelay)
                    .disposed(by: self.rx.reuseBag)
            }
        }
    }
}
