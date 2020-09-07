//
//  SearchViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import RxSwift
import RxCocoa

final class SearchViewController: ViewController<SearchViewModel> {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: TableView!
    
    override func makeUI() {
        
        title = R.string.i18n.search()
        tableView.register(R.nib.taskCell)
    }
    
    override func bindViewModel() {
        
        searchBar.rx.text
            .orEmpty
            .throttle(DispatchTimeInterval.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.searchTasksStarted)
            .disposed(by: disposeBag)
        
        vm.output.tasks
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.taskCell.identifier,
                                      cellType: TaskCell.self)) { (_, taskViewModel, taskCell) in
                    taskCell.vm = taskViewModel
            }
            .disposed(by: disposeBag)
        
        vm.output.refreshing
            .asDriver(onErrorJustReturn: false)
            .drive(tableView.rx.isRefreshing)
            .disposed(by: disposeBag)
        
    }
}
