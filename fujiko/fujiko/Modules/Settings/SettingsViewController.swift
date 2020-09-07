//
//  SettingsViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingsViewController: ViewController<SettingsViewModel> {

    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var logoutButton: Button!
    
    override func makeUI() {
        
        title = R.string.i18n.settings()
        
        tableView.register(R.nib.settingsCell)

    }
    
    override func bindViewModel() {
        
        tableView.rx.itemSelected
            .asDriver()
            .drive(vm.input.tableViewItemsTapped)
            .disposed(by: disposeBag)
        
        logoutButton.rx.tap
            .asDriver()
            .drive(vm.input.logoutTapped)
            .disposed(by: disposeBag)
        
        vm.output.settingsItems
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.settingsCell.identifier,
                                      cellType: SettingsCell.self)) { _, settingsItemviewModel, settingsCell in
                settingsCell.vm = settingsItemviewModel}
            .disposed(by: disposeBag)
    }
}
