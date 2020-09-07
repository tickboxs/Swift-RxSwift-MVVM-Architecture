//
//  DashboardViewModelTests.swift
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
class DashboardViewModelTests: XCTestCase {
    
    var vm: DashboardViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        vm = DashboardViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        
    }
    
    func testTasksNotEmptyWhenPagePresent() {
        
        scheduler.start()
        
        XCTAssert(vm.output.tasks.value.count == 13,
                  "Could not Get tasks")
    }

}
