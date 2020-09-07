//
//  NotificationsViewModelTests.swift
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
class NotificationsViewModelTests: XCTestCase {
    
    var vm: NotificationsViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        vm = NotificationsViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        
    }
    
    func testNotificationsNotEmptyWhenPagePresent() {
        
        scheduler.start()
        
        XCTAssert(vm.output.notifications.value.count == 8,
                  "Could not Get notifications")
    }

}
