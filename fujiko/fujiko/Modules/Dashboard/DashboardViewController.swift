//
//  DashboardViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class DashboardViewController: ViewController<DashboardViewModel> {
    @IBOutlet weak var tableView: TableView!

    override func makeUI() {
        super.makeUI()
        
        title = R.string.i18n.dashboard()
        
        // Settings Button
        let settingsButtonItem: UIBarButtonItem = {
            let settingsButton = Button(type: .custom)
            settingsButton.rx.tap
                .asDriver()
                .drive(vm.input.settingsTapped)
                .disposed(by: disposeBag)
            settingsButton
                .setImage(R.image.settings()?
                .byResize(to: CGSize(width: 30, height: 30)), for: .normal)
            return UIBarButtonItem(customView: settingsButton)
            
        }()
        self.navigationItem.leftBarButtonItem = settingsButtonItem
        
        // Notifications Button
        let notificationsButtonItem: UIBarButtonItem = {
            let notificationsButton = Button(type: .custom)
            notificationsButton.rx.tap
                .asDriver()
                .drive(vm.input.notificationsTapped)
                .disposed(by: disposeBag)
            notificationsButton
                .setImage(R.image.notifications()?
                .byResize(to: CGSize(width: 35, height: 35)), for: .normal)
            return UIBarButtonItem(customView: notificationsButton)
        }()
        self.navigationItem.rightBarButtonItem = notificationsButtonItem
        
        tableView.register(R.nib.taskCell)

    }
    
    override func bindViewModel() {
        
        tableView.rx.itemSelected
            .asDriver()
            .drive(vm.input.taskTapped)
            .disposed(by: disposeBag)
        
        vm.output.tasks
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.taskCell.identifier,
                                      cellType: TaskCell.self)) { (_, taskCellViewModel, taskCell) in
                taskCell.vm = taskCellViewModel }
            .disposed(by: disposeBag)
        
        vm.output.refreshing
            .asDriver()
            .drive(tableView.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}
