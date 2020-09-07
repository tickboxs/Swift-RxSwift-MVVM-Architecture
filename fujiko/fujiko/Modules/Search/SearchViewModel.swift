//
//  SearchViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class SearchViewModel: ViewModel, ViewModelType {
    
    private let apiService = Container.shared.resolve(IApiService.self)!
    
    struct Input {
        let searchTasksStarted: BehaviorRelay<String>
    }
    
    struct Output {
        let tasks: BehaviorRelay<[TaskCellViewModel]>
        let refreshing: BehaviorRelay<Bool>
    }
    
    let input = Input(searchTasksStarted: BehaviorRelay<String>(value: ""))
    let output = Output(tasks: BehaviorRelay<[TaskCellViewModel]>(value: []),
                        refreshing: BehaviorRelay<Bool>(value: false))
    
    override init() {
        super.init()
        
        input.searchTasksStarted
            .do(onNext: { (_) in self.output.refreshing.accept(true) })
            .flatMapLatest { self.apiService.getAllTasks(keyword: $0) }
            .do(onNext: { (_) in self.output.refreshing.accept(false) })
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
            .asDriver(onErrorJustReturn: [])
            .drive(output.tasks)
            .disposed(by: disposeBag)
        
    }
}
