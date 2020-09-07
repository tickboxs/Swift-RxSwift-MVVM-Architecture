//
//  AddTaskViewModelTests.swift
//  fujikoTests
//
//  Created by Charlie Cai on 23/3/20.
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
class AddTasktViewModelTests: XCTestCase {
    
    var vm: AddTaskViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        vm = AddTaskViewModel()
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        
    }
    
    func testCreateButtonIsDisabledWhenPagePresented() {
        XCTAssert(vm.output.createEnabled.value == false,
                      "Create Button has to be disabled when AddProjectViewController presented")
    }
        
    func testCreateButtonTitleColorIsWhiteWhenPagePresented() {
        XCTAssert(vm.output.createTextColor.value == UIColor.white,
                      "Create Button TitleColor has to be white when AddProjectViewController presented")
    }

    func testCreateButtonBackGroundColorWhenPagePresented() {
        XCTAssert(
                vm.output.createBackgroundColor.value == UIColor(Theme.Color.disabledButtonBackgroundColor),
                "Create Button Background has to be gray when AddProjectViewController presented")
    }
    
    func testCreateButtonWhenNameAndDescriptionChange() {

        let isEnable = scheduler.createObserver(Bool.self)
        let titleColor = scheduler.createObserver(UIColor.self)
        let backgroundColor = scheduler.createObserver(UIColor.self)
        
        vm.output.createEnabled
            .asDriver()
            .drive(isEnable)
            .disposed(by: disposeBag)
        
        vm.output.createTextColor
            .asDriver()
            .drive(titleColor)
            .disposed(by: disposeBag)
        
        vm.output.createBackgroundColor
            .asDriver()
            .drive(backgroundColor)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(0, ""),
                                        .next(10, "a new task")])
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.name)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(0, ""),
                                        .next(20, "a new description")])
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.description)
            .disposed(by: disposeBag)

        scheduler.start()
        
        XCTAssertEqual(isEnable.events, [
            .next(0, false),
            .next(0, false),
            .next(0, false),
            .next(10, false),
            .next(20, true)
        ])
        
        let disableTitleColor = UIColor.white
        let enableTitleColor = UIColor(Theme.Color.primary_dark)!
        
        XCTAssertEqual(titleColor.events, [
            .next(0, disableTitleColor),
            .next(0, disableTitleColor),
            .next(0, disableTitleColor),
            .next(10, disableTitleColor),
            .next(20, enableTitleColor)
        ])
        
        let enableBackgroundColor = UIColor(Theme.Color.enabledButtonBackgroundColor)!
        let disableBackgroundColor = UIColor(Theme.Color.disabledButtonBackgroundColor)!
        
        XCTAssertEqual(backgroundColor.events, [
            .next(0, disableBackgroundColor),
            .next(0, disableBackgroundColor),
            .next(0, disableBackgroundColor),
            .next(10, disableBackgroundColor),
            .next(20, enableBackgroundColor)
        ])
    }

}
