//
//  AddProjectViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AddProjectViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let name: BehaviorRelay<String>
        let description: BehaviorRelay<String>
        let dismissed: PublishSubject<Void>
        let invited: PublishSubject<Void>
        let taskStarted: PublishSubject<Void>
    }
    
    struct Output {
        let createEnabled: BehaviorRelay<Bool>
        let createTextColor: BehaviorRelay<UIColor>
        let createBackgroundColor: BehaviorRelay<UIColor>
    }
    
    let input = Input(name: BehaviorRelay<String>(value: ""),
                      description: BehaviorRelay<String>(value: ""),
                      dismissed: PublishSubject<Void>(), invited: PublishSubject<Void>(),
                      taskStarted: PublishSubject<Void>())
    
    let output = Output(createEnabled: BehaviorRelay<Bool>(value: false),
                        createTextColor: BehaviorRelay<UIColor>(value: .white),
                        createBackgroundColor: BehaviorRelay<UIColor>(
                            value: UIColor(Theme.Color.disabledButtonBackgroundColor) ?? .red))
    
    override init() {
        super.init()
        
        input.dismissed
            .subscribe(onNext: { [unowned self] _ in
                self.navigator.dismiss()
            })
            .disposed(by: disposeBag)
        
        input.invited
            .subscribe(onNext: { [unowned self] _ in
                self.navigator.push(scene: .invite(viewModel: InviteViewModel()))
            })
            .disposed(by: disposeBag)
        
        input.taskStarted
            .subscribe(onNext: { [unowned self] _ in
                self.navigator.push(scene: .addTask(viewModel: AddTaskViewModel()))
            })
            .disposed(by: disposeBag)
        
        Driver
            .combineLatest(
                input.name.asDriver().map { $0 != "" },
                input.description.asDriver().map { $0 != "" })
            .map { $0 && $1 }
            .drive(output.createEnabled).disposed(by: disposeBag)
            
        output.createEnabled
            .asDriver()
            .map { $0 ? UIColor(Theme.Color.primary_dark)! : .white }
            .drive(output.createTextColor)
            .disposed(by: disposeBag)
        
        output.createEnabled
            .asDriver()
            .map { $0 ?
                UIColor(Theme.Color.enabledButtonBackgroundColor) ?? .red:
                UIColor(Theme.Color.disabledButtonBackgroundColor) ?? .red }
            .drive(output.createBackgroundColor)
            .disposed(by: disposeBag)
    }
}
