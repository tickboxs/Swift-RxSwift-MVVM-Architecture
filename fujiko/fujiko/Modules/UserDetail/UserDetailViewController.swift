//
//  UserDetailViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 16/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class UserDetailViewController: ViewController<UserDetailViewModel> {
    
    @IBOutlet weak var userNameLabel: Label!
    @IBOutlet weak var userEmailLabel: Label!
    @IBOutlet weak var slidingTabBar: SlidingTabBar!
    @IBOutlet weak var chatButton: Button!
    @IBOutlet weak var callButton: Button!
    @IBOutlet weak var tableView: TableView!
    
    override func makeUI() {
        
        tableView.register(R.nib.userDetailCell)
    }
    
    override func bindViewModel() {
        
        chatButton.rx.tap
            .asDriver()
            .drive(vm.input.chatTapped)
            .disposed(by: disposeBag)
        
        callButton.rx.tap
            .asDriver()
            .drive(vm.input.callTapped)
            .disposed(by: disposeBag)
        
        vm.output.userDetailItems
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.userDetailCell.identifier,
                                      cellType: UserDetailCell.self)) { (_, userDetailCellViewModel, userDetailCell) in
                userDetailCell.vm = userDetailCellViewModel}
            .disposed(by: disposeBag)
    }

}
