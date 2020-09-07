//
//  ProfileViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Rswift
import SVProgressHUD

final class ProfileViewController: ViewController<ProfileViewModel> {
    
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var editProfileButton: Button!
    @IBOutlet weak var changePhotoButton: Button!
    
    override func makeUI() {
        
        navigationController?.title = R.string.i18n.profile()
        
        tableView.register(R.nib.profileCell)
        
        editProfileButton.rx.tap
            .subscribe(onNext: { _ in
                SVProgressHUD.showInfo(withStatus: "TODO")
            })
            .disposed(by: disposeBag)
        
        changePhotoButton.rx.tap
            .subscribe(onNext: { _ in
                SVProgressHUD.showInfo(withStatus: "TODO")
            })
            .disposed(by: disposeBag)
        
    }
    
    override func bindViewModel() {
        
        vm.output.userItems
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.profileCell.identifier,
                                      cellType: ProfileCell.self)) { (_, profileCellViewModel, profileCell) in
                profileCell.vm = profileCellViewModel}
            .disposed(by: disposeBag)
        
    }
    
}
