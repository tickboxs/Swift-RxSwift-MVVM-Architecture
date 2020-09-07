//
//  TabBarController.swift
//  fujiko
//
//  Created by Charlie Cai on 10/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TabBarController: UITabBarController {

    func makeUI() { }
    func bindViewModel() { }
    
    let vm: ViewModel
    let disposeBag = DisposeBag()
    
    init(vm: ViewModel) {
        
        self.vm = vm
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindViewModel()

    }

}
