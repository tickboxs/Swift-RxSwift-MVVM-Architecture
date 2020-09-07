//
//  IntroViewModelTests.swift
//  fujikoTests
//
//  Created by Charlie Cai on 21/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import fujiko
class IntroViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var vm: IntroViewModel!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
//        let mockNavigator = NavigatorTypeMock()
    }

    override func tearDown() {
        
    }
//
//    func testTappedPlayPauseChangesIsPlaying() {
//      // 1
//      let isPlaying = scheduler.createObserver(Bool.self)
//
//      // 2
//      viewModel.isPlaying
//        .drive(isPlaying)
//        .disposed(by: disposeBag)
//
//      // 3
//      scheduler.createColdObservable([.next(10, ()),
//                                      .next(20, ()),
//                                      .next(30, ())])
//               .bind(to: viewModel.tappedPlayPause)
//               .disposed(by: disposeBag)
//
//      // 4
//      scheduler.start()
//
//      // 5
//      XCTAssertEqual(isPlaying.events, [
//        .next(0, false),
//        .next(10, true),
//        .next(20, false),
//        .next(30, true)
//      ])
//    }

}
