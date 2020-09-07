//
//  StatisticsViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class StatisticsViewModel: ViewModel, ViewModelType {
    
    private let apiService = Container.shared.resolve(IApiService.self)!
    
    struct Input {
        let loadStatisticsStarted: BehaviorRelay<StatisticsStatus>
        let settingsTapped: PublishSubject<Void>
        let notificationsTapped: PublishSubject<Void>
    }
    
    struct Output {
        let statistics: BehaviorRelay<[StatisticsVM]>
    }
    
    let input = Input(loadStatisticsStarted: BehaviorRelay<StatisticsStatus>(value: .in_progress),
                      settingsTapped: PublishSubject<Void>(),
                      notificationsTapped: PublishSubject<Void>())
    let output = Output(statistics: BehaviorRelay<[StatisticsVM]>(value: []))
    
    override init() {
        super.init()
        
        input.loadStatisticsStarted
            .flatMapLatest { self.apiService.getAllStatistics(statisticsStatus: $0) }
            .map { (response) -> [Statistics] in
                if response.code == .ok {
                    return response.data ?? []
                } else {
                    return []
                }
            }
            .map { (statisticses) -> [StatisticsVM] in
                return statisticses.map { (statistics) -> StatisticsVM in
                    return StatisticsVM(statistics: statistics)
                }
        }
        .asDriver(onErrorJustReturn: [])
        .drive(output.statistics)
        .disposed(by: disposeBag)
        
        input.notificationsTapped.subscribe(onNext: { [unowned self] _ in
            self.navigator.push(scene: .notifications(viewModel: NotificationsViewModel()))
        }).disposed(by: disposeBag)
        
        input.settingsTapped.subscribe(onNext: { [unowned self] _ in
            self.navigator.push(scene: .settings(viewModel: SettingsViewModel()))
        }).disposed(by: disposeBag)
    
    }

}
