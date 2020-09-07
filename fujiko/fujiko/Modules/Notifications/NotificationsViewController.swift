//
//  NotificationsViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class NotificationsViewController: ViewController<NotificationsViewModel> {
    
    @IBOutlet weak var tableView: TableView!
    
    override func makeUI() {
        
        title = R.string.i18n.notifications()
        tableView.register(R.nib.notificationsCell)
    }
    
    override func bindViewModel() {
        
        vm.output.notifications
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(
                cellIdentifier: R.reuseIdentifier.notificationsCell.identifier,
                cellType: NotificationsCell.self)) {
                    [unowned self]
                    (_, notificationsCellViewModel, notificationsCell) in
                                        
                    notificationsCell.vm = notificationsCellViewModel
                    notificationsCell.avatarTapped
                        .asDriver(onErrorJustReturn: ())
                        .drive(self.vm.input.avatarTapped)
                        .disposed(by: notificationsCell.rx.reuseBag)
                    
            }
            .disposed(by: disposeBag)
        
        vm.output.refreshing
            .asDriver()
            .drive(tableView.rx.isRefreshing)
            .disposed(by: disposeBag)
        
    }

}
