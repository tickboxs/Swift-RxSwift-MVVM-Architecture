//
//  UserDetailCell.swift
//  fujiko
//
//  Created by Charlie Cai on 16/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit

final class UserDetailCell: TableViewCell {

    @IBOutlet weak var topLabel: Label!
    @IBOutlet weak var bottomLabel: Label!
    
    public var vm: UserDetailCellViewModel? {
        didSet {
            topLabel.text = vm?.topText
            bottomLabel.text = vm?.bottomText
        }
    }
}
