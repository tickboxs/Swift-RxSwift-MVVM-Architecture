//
//  InviteViewModelTests.swift
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
class InviteViewModelTests: XCTestCase {
    
    var vm: InviteViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        vm = InviteViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        
    }
    
    func testUsersNotEmptyWhenPagePresent() {
        
        XCTAssert(vm.output.members.value.count == 10,
                  "Could not Get members")
    }
    
    func testCellSelectableWhenCellTapped() {
        
        let isInviting = scheduler.createObserver(Bool.self)
        
        vm.output.members
            .value[0]
            .isInviting
            .asDriver()
            .drive(isInviting)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, IndexPath(row: 0, section: 0)),
                                        .next(20, IndexPath(row: 0, section: 0)),
                                        .next(30, IndexPath(row: 0, section: 0)),
                                        .next(40, IndexPath(row: 1, section: 0))])
            .asDriver(onErrorJustReturn: IndexPath(row: 0, section: 0))
            .drive(vm.input.cellTapped)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isInviting.events, [
            .next(0, false),
            .next(10, true),
            .next(20, false),
            .next(30, true)
        ])
    }

}
