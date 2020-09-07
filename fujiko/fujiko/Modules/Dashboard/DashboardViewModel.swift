//
//  DashboardViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class DashboardViewModel: ViewModel, ViewModelType {
    
    private let apiService = Container.shared.resolve(IApiService.self)!
    
    struct Input {
        let loadTasksStarted: BehaviorRelay<Void>
        let settingsTapped: PublishSubject<Void>
        let notificationsTapped: PublishSubject<Void>
        let taskTapped: PublishSubject<IndexPath>
    }
    
    struct Output {
        let tasks: BehaviorRelay<[TaskCellViewModel]>
        let refreshing: BehaviorRelay<Bool>
    }
    
    let input = Input(loadTasksStarted: BehaviorRelay<Void>(value: ()),
                      settingsTapped: PublishSubject<Void>(),
                      notificationsTapped: PublishSubject<Void>(),
                      taskTapped: PublishSubject<IndexPath>())
    let output = Output(tasks: BehaviorRelay<[TaskCellViewModel]>(value: []),
                        refreshing: BehaviorRelay<Bool>(value: false))
    
    override init() {
        super.init()
        
        input.loadTasksStarted
            .do(onNext: { _ in self.output.refreshing.accept(true) })
            .flatMapLatest { _ in self.apiService.getAllTasks(keyword: "") }
            .do(onNext: { _ in self.output.refreshing.accept(false) })
            .map { (response) -> [Task] in
                if response.code == .ok {
                    return response.data ?? []
                } else {
                    return []
                }
            }
            .map { (tasks) -> [TaskCellViewModel] in
                return tasks.map { (task) -> TaskCellViewModel in
                    TaskCellViewModel(task: task)
                }
            }
        .asDriver(onErrorJustReturn: []).drive(output.tasks)
        .disposed(by: disposeBag)
        
        input.settingsTapped.subscribe(onNext: { [unowned self] _ in
            self.navigator.push(scene: .settings(viewModel: SettingsViewModel()))
        }).disposed(by: disposeBag)
        
        input.notificationsTapped.subscribe(onNext: { [unowned self] _ in
            self.navigator.push(scene: .notifications(viewModel: NotificationsViewModel()))
        }).disposed(by: disposeBag)
        
        input.taskTapped.subscribe(onNext: { [unowned self] (indexPath) in
            self.navigator.push(scene: .taskOverview(viewModel: TaskOverviewViewModel()))
        }).disposed(by: disposeBag)
    }
}
