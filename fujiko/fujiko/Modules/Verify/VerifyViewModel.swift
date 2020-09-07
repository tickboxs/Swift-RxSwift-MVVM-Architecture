//
//  VerifyViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 14/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD
import Localize_Swift
import Swinject

final class VerifyViewModel: ViewModel, ViewModelType {
    
    private let localStorageService = Container.shared.resolve(ILocalStorageService.self)!
    
    struct Input {
        let resended: PublishSubject<Void>
        let codeInputed: PublishSubject<String>
    }
    
    struct Output {
        
    }
    
    let input = Input(resended: PublishSubject<Void>(), codeInputed: PublishSubject<String>())
    let output = Output()
    
    override init() {
        super.init()
        
        input.resended.subscribe(onNext: { _ in
            SVProgressHUD.showInfo(withStatus: R.string.i18n.code_resent())
            Logger.log("Resending Code", .verbose)
        }).disposed(by: disposeBag)
        
        input.codeInputed.subscribe(onNext: { [unowned self] _ in
            SVProgressHUD.showSuccess(withStatus: R.string.i18n.success())
            if let keyWindow = UIWindow.keyWindow {
                
                let userJson = User(role: "Developer",
                                    team: "UI Team",
                                    email: EmailPW(email: "cai.charlie@hotmail.com"),
                                    avatar: "", status: .active,
                                    chat: true,
                                    call: true,
                                    signUpTimestamp: UnixTimestampPW(timestamp: 1583859791336)).toJSON()
                
                self.localStorageService.setValueFor(key: Configs.KEY_USER, value: userJson)
                self.navigator.switchRoot(keyWindow: keyWindow,
                                          scene: .main(viewModel: MainTabBarViewModel()))
                Logger.log("Successfully Verified", .debug)
            } else {
                Logger.log("Could not get KeyWindow At VerifyViewController", .error)
            }
        }).disposed(by: disposeBag)
    }
}
