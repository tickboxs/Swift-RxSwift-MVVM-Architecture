//
//  CalendarViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import JTAppleCalendar

final class CalendarViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let settingsTapped: PublishSubject<Void>
        let searchTapped: PublishSubject<Void>
        let previousNextTapped: PublishSubject<SegmentDestination>
    }
    
    struct Output {
        let dateRelay: BehaviorRelay<Date>
        let pageTranslation: PublishSubject<SegmentDestination>
    }
    
    let input = Input(settingsTapped: PublishSubject<Void>(),
                      searchTapped: PublishSubject<Void>(),
                      previousNextTapped: PublishSubject<SegmentDestination>())
    let output = Output(dateRelay: BehaviorRelay<Date>(value: Date()),
                        pageTranslation: PublishSubject<SegmentDestination>())
    
    override init() {
        super.init()
        
        input.settingsTapped.subscribe(onNext: { [unowned self] _ in
            self.navigator.push(scene: .settings(viewModel: SettingsViewModel()))
        }).disposed(by: disposeBag)
        
        input.searchTapped.subscribe(onNext: { [unowned self] _ in
            self.navigator.push(scene: .search(viewModel: SearchViewModel()))
        }).disposed(by: disposeBag)
        
        input.previousNextTapped.asDriver(onErrorJustReturn: .previous).do(onNext: { (segmentDestination) in
            let date = self.output.dateRelay.value
            let value = segmentDestination == .previous ? -1 : 1
            
            if let newDate = Calendar.current.date(byAdding: .month, value: value, to: date) {
                self.output.dateRelay.accept(newDate)
            } else {
                Logger.log("Get Date Error", .warn)
            }
        })
        .drive(output.pageTranslation)
        .disposed(by: disposeBag)
    }
}
