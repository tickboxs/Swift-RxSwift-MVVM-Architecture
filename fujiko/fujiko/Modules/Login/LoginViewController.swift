//
//  LoginViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import Localize_Swift
import RxSwift
import RxCocoa
import RxBiBinding
import Rswift
import SnapKit
import RxKeyboard
import SwiftyJSON
import RxSwiftExt

final class LoginViewController: ViewController<LoginViewModel> {

    @IBOutlet weak var slidingTaBar: SlidingTabBar!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var loginButton: LoadableButton!
    @IBOutlet weak var hintLabel: Label!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    override func makeUI() {

        emailTextField.placeholder = R.string.i18n.email()
        passwordTextField.placeholder = R.string.i18n.password()
        nameTextField.placeholder = R.string.i18n.name()
        loginButton.setTitle(R.string.i18n.login(), for: .normal)

    }

    override func bindViewModel() {
        
        forgetPasswordButton.rx.tap
            .asDriver()
            .drive(vm.input.forgetTapped)
            .disposed(by: disposeBag)

        (slidingTaBar.rx.tap <-> vm.input.tabSelected).disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .asDriver()
            .drive(vm.input.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .asDriver()
            .drive(vm.input.password)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text
            .orEmpty
            .asDriver()
            .drive(vm.input.name)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .asDriver()
            .drive(vm.input.logined)
            .disposed(by: disposeBag)
        
        vm.output.loginEnabled
            .asDriver()
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        vm.output.loginBackgroundColor
            .asDriver()
            .drive(loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        vm.output.loginTitleColor
            .asDriver()
            .drive(loginButton.rx.titleColor)
            .disposed(by: disposeBag)
        
        vm.output.hintHidden
            .asDriver()
            .drive(hintLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        vm.output.hintText
            .asDriver()
            .drive(hintLabel.rx.text)
            .disposed(by: disposeBag)
        
        vm.output.loaded.asDriver()
            .drive(loginButton.rx.loading)
            .disposed(by: disposeBag)
        
        vm.output.nameHidden
            .asDriver()
            .drive(nameTextField.rx.isHidden)
            .disposed(by: disposeBag)
        
        vm.output.forgetHidden
            .asDriver()
            .drive(forgetPasswordButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        vm.output.loginTitle
            .asDriver()
            .drive(loginButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { (height) in
                self.view.transform = CGAffineTransform(translationX: 0, y: -height)
            })
            .disposed(by: disposeBag)
        
        view.rx.tapGesture
            .subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
}
