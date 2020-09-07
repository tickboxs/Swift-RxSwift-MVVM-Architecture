//
//  ViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift

class ViewController<T: ViewModel>: UIViewController {
    
    // Design Pattern Here
    // Template Methods
    func makeUI() { }
    func bindViewModel() { }
    
    let vm: T
    let disposeBag = DisposeBag()
    
    init(vm: T) {
        
        self.vm = vm
        
        // Initialize ViewController from nib of the same class name
        super.init(nibName: String(describing: type(of: self)), bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindViewModel()
        
        vm.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.viewWillAppear(animated)
        
//        try? reachability?.startNotifier()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        vm.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        vm.viewWillDisappear(animated)
        
//        reachability?.stopNotifier()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        vm.viewDidDisappear(animated)
    }
    
    deinit {
        Logger.log("\(self.className()) deinit", .debug)
    }
}


