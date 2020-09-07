//
//  LoginViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject
import Localize_Swift
import SVProgressHUD

final class LoginViewModel: ViewModel, ViewModelType {
    
    private let apiService: IApiService = Container.shared.resolve(IApiService.self)!
    private let localStorageService = Container.shared.resolve(ILocalStorageService.self)!
    
    struct Input {
        let email: BehaviorRelay<String>
        let password: BehaviorRelay<String>
        let name: BehaviorRelay<String>
        let logined: PublishSubject<Void>
        let tabSelected: BehaviorRelay<Int>
        let forgetTapped: PublishSubject<Void>
    }
    
    struct Output {
        let loginEnabled: BehaviorRelay<Bool>
        let loginBackgroundColor: BehaviorRelay<UIColor>
        let loginTitleColor: BehaviorRelay<UIColor>
        let loginTitle: BehaviorRelay<String>
        let hintHidden: BehaviorRelay<Bool>
        let hintText: BehaviorRelay<String>
        let loaded: BehaviorRelay<Bool>
        let forgetHidden: BehaviorRelay<Bool>
        let nameHidden: BehaviorRelay<Bool>
    }
    
    let input: Input = Input(email: BehaviorRelay<String>(value: ""),
                            password: BehaviorRelay<String>(value: ""),
                            name: BehaviorRelay<String>(value: ""),
                            logined: PublishSubject<Void>(),
                            tabSelected: BehaviorRelay<Int>(value: 0),
                            forgetTapped: PublishSubject<Void>())
    
    let output: Output = Output(loginEnabled: BehaviorRelay<Bool>(value: true),
                               loginBackgroundColor: BehaviorRelay<UIColor>(value:
                                UIColor(Theme.Color.disabledButtonBackgroundColor) ?? .red),
                               loginTitleColor: BehaviorRelay<UIColor>(value: .white),
                               loginTitle: BehaviorRelay<String>(value: R.string.i18n.login()),
                               hintHidden: BehaviorRelay<Bool>(value: true),
                               hintText: BehaviorRelay<String>(value: ""),
                               loaded: BehaviorRelay<Bool>(value: false),
                               forgetHidden: BehaviorRelay<Bool>(value: false),
                               nameHidden: BehaviorRelay<Bool>(value: true))
    
    init(selectedIndex: Int) {
        super.init()

        input.tabSelected.accept(selectedIndex)
        
        input.forgetTapped.subscribe(onNext: { _ in
                SVProgressHUD.showInfo(withStatus: "Forget Process to be done")
            })
            .disposed(by: disposeBag)
        
        input.tabSelected
            .map { $0 == 0 }
            .asDriver(onErrorJustReturn: true)
            .drive(output.nameHidden)
            .disposed(by: disposeBag)
        
        input.tabSelected
            .map { $0 == 1 }
            .asDriver(onErrorJustReturn: true)
            .drive(output.forgetHidden)
            .disposed(by: disposeBag)
        
        input.tabSelected
            .map { $0 == 0 ? R.string.i18n.login() : R.string.i18n.signUp()  }
            .asDriver(onErrorJustReturn: R.string.i18n.login())
            .drive(output.loginTitle)
            .disposed(by: disposeBag)

        Observable
            .combineLatest(
                input.email.map { $0 != ""},
                input.password.map { $0 != ""},
                input.name.map { $0 != ""},
                input.tabSelected.map { $0 == 0}
            )
            .map { $0 && $1 && ($2 || $3)}
            .asDriver(onErrorJustReturn: false)
            .drive(output.loginEnabled)
            .disposed(by: disposeBag)
        
        output.loginEnabled
            .map { $0 ?
                UIColor(Theme.Color.enabledButtonBackgroundColor) ?? .red :
                UIColor(Theme.Color.disabledButtonBackgroundColor) ?? .red }
            .asDriver(onErrorJustReturn: UIColor(Theme.Color.disabledButtonBackgroundColor) ?? .red)
            .drive(output.loginBackgroundColor)
            .disposed(by: disposeBag)
        
        output.loginEnabled
            .map { $0 ? UIColor(Theme.Color.primary_dark)! : .white }
            .asDriver(onErrorJustReturn: .white)
            .drive(output.loginTitleColor)
            .disposed(by: disposeBag)
        
        input.logined
            .map { [unowned self]() -> String in
            return self.validateEmailandPassword(email: self.input.email.value, password: self.input.password.value)
        }
        .map { ($0, $0 == "") }
        .flatMapLatest { (arg0) -> Observable<HttpResponse<User>> in
            
            let (text, isValid) = arg0
            if isValid {
                self.output.loaded.accept(true)
                if self.input.tabSelected.value == 0 {
                    return self.apiService.login(email: self.input.email.value,
                                                 password: self.input.password.value)
                } else {
                    return self.apiService.signUp(email: self.input.email.value,
                                                  password: self.input.password.value,
                                                  name: self.input.name.value)
                }
            } else {
                return .just(HttpResponse<User>(code: .error, data: nil, errorMessage: text))
            }
        }
        .asDriver(onErrorJustReturn: HttpResponse<User>(code: .error, data: nil, errorMessage: "something went wrong"))
        .do(onNext: { [unowned self](response) in
            
            self.output.loaded.accept(false)
            
            let hintText = response.errorMessage ?? ""
            
            if let userJson = response.data?.toJSON() {
                // Store user object locally
                self.localStorageService.setValueFor(key: Configs.KEY_USER, value: userJson)
            } else {
                Logger.log("Login With Wrong Info Or Could not get user data from API," +
                           "please double check with backend team", .warn)
            }
            
            // hintText == "" means everything goes well
            // Login
            if hintText == "" && self.input.tabSelected.value == 0 {
                    
                 self.navigator.push(scene: .main(viewModel: MainTabBarViewModel()))
            }
            // Sign up
            else if hintText == "" && self.input.tabSelected.value == 1 {
                 self.navigator.push(scene: .verify(viewModel: VerifyViewModel()))
            }
        })
        .map { $0.errorMessage ?? ""}
        .drive(output.hintText)
        .disposed(by: disposeBag)
        
        output.hintText.map { $0 == "" }
            .asDriver(onErrorJustReturn: false)
            .drive(output.hintHidden)
            .disposed(by: disposeBag)
        
        Driver
            .merge(input.email.asDriver(),
                   input.password.asDriver(),
                   input.name.asDriver()
            )
            .map { _ in true }
            .drive(output.hintHidden)
            .disposed(by: disposeBag)
        
    }
    
    // Email and password validator
    private func validateEmailandPassword(email: String, password: String) -> String {
        
        // validate email
        if !email.isValidEmail() {
            return R.string.i18n.incorrect_email_format()
        }
        
        // password can only be 6 to 20 digits of English letters plus numbers and
        // the following special characters!@#$&_-
        if password.range(of: "^[a-z0-9A-Z!@#$&_-]{6,20}$",
                          options: .regularExpression,
                          range: nil, locale: nil) == nil {
            return R.string.i18n.incorrect_password_format()
        }
        
        return ""
    }
    
}
