//
//  InviteViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Localize_Swift

final class InviteViewController: ViewController<InviteViewModel> {
    
    @IBOutlet weak var notListedLabel: Label!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: TableView!
    
    override func makeUI() {
        
        title = R.string.i18n.invite()
        notListedLabel.text = R.string.i18n.not_listed()
        
        tableView.register(R.nib.inviteCell)
    }
    
    override func bindViewModel() {
        
        searchBar.rx.value
            .orEmpty
            .throttle(DispatchTimeInterval.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(vm.input.searchInputed)
            .disposed(by: disposeBag)

        vm.output.members
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.inviteCell.identifier,
                                      cellType: InviteCell.self)) { (_, inviteCellViewModel, inviteCell) in
                inviteCell.vm = inviteCellViewModel
            }
            .disposed(by: disposeBag)
        
        vm.output.refreshing
            .asDriver()
            .drive(tableView.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asDriver()
            .drive(vm.input.cellTapped)
            .disposed(by: disposeBag)
    }

}
