//
//  LoginViewModelTests.swift
//  fujikoTests
//
//  Created by Charlie Cai on 22/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import fujiko
class LoginViewModelTests: XCTestCase {
    
    var vm: LoginViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        vm = LoginViewModel(selectedIndex: 0)
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        
    }
    
    func testLoginButtonIsDisabledWhenPagePresented() {
        XCTAssert(vm.output.loginEnabled.value == false,
                  "Login Button has to be disabled when LoginViewController presented")
    }
    
    func testLoginButtonTitleColorIsWhiteWhenPagePresented() {
        XCTAssert(vm.output.loginTitleColor.value == UIColor.white,
                  "Login Button TitleColor has to be white when LoginViewController presented")
    }

    func testLoginButtonBackGroundColorWhenPagePresented() {
        XCTAssert(
            vm.output.loginBackgroundColor.value == UIColor(Theme.Color.disabledButtonBackgroundColor),
            "Login Button Background has to be gray when LoginViewController presented")
    }
    
    func testLoginButtonWhenEmailAndPasswordChange() {

        let isEnable = scheduler.createObserver(Bool.self)
        let titleColor = scheduler.createObserver(UIColor.self)
        let backgroundColor = scheduler.createObserver(UIColor.self)
        
        vm.output.loginEnabled
            .asDriver()
            .drive(isEnable)
            .disposed(by: disposeBag)
        
        vm.output.loginTitleColor
            .asDriver()
            .drive(titleColor)
            .disposed(by: disposeBag)
        
        vm.output.loginBackgroundColor
            .asDriver()
            .drive(backgroundColor)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(0, ""),
                                        .next(10, "cai.charlie@hotmail.com"),
                                        .next(30, ""),
                                        .next(50, "cai.charlie@hotmail.com")])
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.email)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(0, ""),
                                        .next(20, "cometoseeme"),
                                        .next(40, ""),
                                        .next(50, "cometoseeme")])
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.password)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(60, 1),
                                        .next(90, 0)])
            .asDriver(onErrorJustReturn: 0)
            .drive(vm.input.tabSelected)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(70, "charlie cai"),
                                        .next(80, "")])
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.name)
            .disposed(by: disposeBag)

        scheduler.start()
        
        XCTAssertEqual(isEnable.events, [
            .next(0, false),
            .next(0, false),
            .next(0, false),
            .next(10, false),
            .next(20, true),
            .next(30, false),
            .next(40, false),
            .next(50, false),
            .next(50, true),
            .next(60, false),
            .next(70, true),
            .next(80, false),
            .next(90, true)
        ])
        
        let disableTitleColor = UIColor.white
        let enableTitleColor = UIColor(Theme.Color.primary_dark)!
        
        XCTAssertEqual(titleColor.events, [
            .next(0, disableTitleColor),
            .next(0, disableTitleColor),
            .next(0, disableTitleColor),
            .next(10, disableTitleColor),
            .next(20, enableTitleColor),
            .next(30, disableTitleColor),
            .next(40, disableTitleColor),
            .next(50, disableTitleColor),
            .next(50, enableTitleColor),
            .next(60, disableTitleColor),
            .next(70, enableTitleColor),
            .next(80, disableTitleColor),
            .next(90, enableTitleColor)
        ])
        
        let enableBackgroundColor = UIColor(Theme.Color.enabledButtonBackgroundColor)!
        let disableBackgroundColor = UIColor(Theme.Color.disabledButtonBackgroundColor)!
        
        XCTAssertEqual(backgroundColor.events, [
            .next(0, disableBackgroundColor),
            .next(0, disableBackgroundColor),
            .next(0, disableBackgroundColor),
            .next(10, disableBackgroundColor),
            .next(20, enableBackgroundColor),
            .next(30, disableBackgroundColor),
            .next(40, disableBackgroundColor),
            .next(50, disableBackgroundColor),
            .next(50, enableBackgroundColor),
            .next(60, disableBackgroundColor),
            .next(70, enableBackgroundColor),
            .next(80, disableBackgroundColor),
            .next(90, enableBackgroundColor)
        ])
    }
    
    func testLoginButtonTitleWhenTabBarTapped() {

        let title = scheduler.createObserver(String.self)
        
        vm.output.loginTitle
            .asDriver()
            .drive(title)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, 1),
                                        .next(20, 0),
                                        .next(30, 1)])
            .asDriver(onErrorJustReturn: 0)
            .drive(vm.input.tabSelected)
            .disposed(by: disposeBag)

        scheduler.start()
        
        XCTAssertEqual(title.events, [
            .next(0, R.string.i18n.login()),
            .next(10, R.string.i18n.signUp()),
            .next(20, R.string.i18n.login()),
            .next(30, R.string.i18n.signUp())
        ])
    }
    
    func testNameTextFieldIsHiddenWhenTabBarTapped() {

        let isHidden = scheduler.createObserver(Bool.self)
        
        vm.output.nameHidden
            .asDriver()
            .drive(isHidden)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, 1),
                                        .next(20, 0),
                                        .next(30, 1)])
            .asDriver(onErrorJustReturn: 0)
            .drive(vm.input.tabSelected)
            .disposed(by: disposeBag)

        scheduler.start()
        
        XCTAssertEqual(isHidden.events, [
            .next(0, true),
            .next(10, false),
            .next(20, true),
            .next(30, false)
        ])
    }
    
    func testErrorMessageWhenLoginButtonTapped() {

        let errorMessage = scheduler.createObserver(String.self)
        let isHintHidden = scheduler.createObserver(Bool.self)
        
        vm.output.hintText
            .asDriver()
            .drive(errorMessage)
            .disposed(by: disposeBag)
        
        vm.output.hintHidden
            .asDriver()
            .drive(isHintHidden)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(0, "caicharlie@"),
                                        .next(30, "cai.charlie@hotmail.com")])
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.email)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, "cometoseeme"),
                                        .next(40, "123"),
                                        .next(60, "123456789"),
                                        .next(80, "cometoseeme")])
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.password)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(20, ()),
                                        .next(50, ()),
                                        .next(70, ()),
                                        .next(90, ())])
            .asDriver(onErrorJustReturn: ())
            .drive(vm.input.logined)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(errorMessage.events, [
            .next(0, ""),
            .next(20, R.string.i18n.incorrect_email_format()),
            .next(50, R.string.i18n.incorrect_password_format()),
            .next(70, R.string.i18n.email_or_password_wrong()),
            .next(90, "")])
        
        XCTAssertEqual(isHintHidden.events, [
            .next(0, true),
            .next(0, true),
            .next(10, true),
            .next(20, false),
            .next(30, true),
            .next(40, true),
            .next(50, false),
            .next(60, true),
            .next(70, false),
            .next(80, true),
            .next(90, true)])
    }

}
