//
//  ViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

protocol DisposeBagable {
    var disposeBag: DisposeBag { get }
}

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    
}

class ViewModel: NSObject, Navigatable, DisposeBagable, LifecycleAwarable {
    
    let navigator: INavigator = Container.shared.resolve(INavigator.self)!
    let disposeBag = DisposeBag()
    
    // Lifecycle Related Methods
    // You could hook more ViewController method here such as LayoutSubviews etc.
    func viewDidLoad() { }
    func viewWillAppear(_ animated: Bool) { }
    func viewDidAppear(_ animated: Bool) { }
    func viewWillDisappear(_ animated: Bool) { }
    func viewDidDisappear(_ animated: Bool) { }
    
    deinit {
        Logger.log("\(self.className()) deinit", .debug)
    }
    
}
