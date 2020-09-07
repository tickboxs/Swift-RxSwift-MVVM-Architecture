//
//  InviteCell.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class InviteCell: TableViewCell {
    
    @IBOutlet weak var avatarImageView: ImageView!
    @IBOutlet weak var emailLabel: Label!
    @IBOutlet weak var checkboxImageView: ImageView!
    
    public var vm: InviteCellViewModel? {
        didSet {
            emailLabel.text = vm?.email
            
            if let vm = vm {
                vm.isInviting
                    .asDriver()
                    .map { $0 ? R.image.checkbox_selected() :
                                R.image.checkbox_unselected() }
                    .drive(self.checkboxImageView.rx.image)
                    .disposed(by: rx.reuseBag)
            }

        }
    }
    
}
