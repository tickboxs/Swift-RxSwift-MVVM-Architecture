//
//  IntroViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Rswift
import RxKeyboard

final class IntroViewController: ViewController<IntroViewModel> {

    @IBOutlet weak var signUpButton: Button!
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var slogenHeader: Label!
    @IBOutlet weak var slogenDescription: Label!
    
    override func makeUI() {
        super.makeUI()
        
        slogenHeader.text = R.string.i18n.slogen_header()
        slogenDescription.text = R.string.i18n.slogen_description()
        
        loginButton.setTitle(R.string.i18n.login(), for: .normal)
        signUpButton.setTitle(R.string.i18n.signUp(), for: .normal)
        
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        loginButton.rx.tap
            .bind(to: vm.input.logined)
            .disposed(by: disposeBag)

        signUpButton.rx.tap
            .bind(to: vm.input.signUped)
            .disposed(by: disposeBag)
        
    }
    
}
