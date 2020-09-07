//
//  VerifyViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 14/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import Localize_Swift

class VerifyViewController: ViewController<VerifyViewModel> {

    @IBOutlet weak var verifyAccountLabel: Label!
    @IBOutlet weak var verifyDescriptionLabel: Label!
    @IBOutlet weak var notGetCodeLabel: Label!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var verificationView: VerificationBoxView!
    
    override func makeUI() {
        
        verifyAccountLabel.text = R.string.i18n.verify_header()
        verifyDescriptionLabel.text = R.string.i18n.verify_description()
        notGetCodeLabel.text = R.string.i18n.not_get_code()
        resendButton.setTitle(R.string.i18n.resend(), for: .normal)
    }
    
    override func bindViewModel() {
        
        verificationView.rx.input
            .filter { $0.1 == true }
            .asDriver(onErrorJustReturn: ("", false))
            .map { $0.0 }
            .drive(vm.input.codeInputed)
            .disposed(by: disposeBag)
        
        resendButton.rx.tap
            .asDriver()
            .drive(vm.input.resended)
            .disposed(by: disposeBag)
    }

}
