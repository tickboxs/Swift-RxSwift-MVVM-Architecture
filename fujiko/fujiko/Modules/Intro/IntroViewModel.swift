//
//  IntroViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class IntroViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let logined: PublishSubject<Void>
        let signUped: PublishSubject<Void>
    }
    
    struct Output { }
    
    let input = Input(logined: PublishSubject<Void>(),
                      signUped: PublishSubject<Void>())
    
    let output = Output()
    
    override init() {
        super.init()
        
        input.logined
            .subscribe(onNext: { [unowned self] _ in
                //Push to login
                self.navigator.push(scene: .login(viewModel: LoginViewModel(selectedIndex: 0)))
            })
            .disposed(by: disposeBag)
        
        input.signUped
            .subscribe(onNext: { [unowned self] _ in
                // Push to signUp
                self.navigator.push(scene: .login(viewModel: LoginViewModel(selectedIndex: 1)))
            })
            .disposed(by: disposeBag)
    }
    
}
