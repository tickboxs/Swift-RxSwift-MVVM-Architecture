//
//  AddTaskViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AddTaskViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let invited: PublishSubject<Void>
        let dueDateTapped: PublishSubject<Void>
        let name: BehaviorRelay<String>
        let description: BehaviorRelay<String>
        let checkListTapped: PublishSubject<Void>
        let attachmentsTapped: PublishSubject<Void>
        let watchTapped: PublishSubject<Void>
        
    }
    
    struct Output {
        let createEnabled: BehaviorRelay<Bool>
        let createTextColor: BehaviorRelay<UIColor>
        let createBackgroundColor: BehaviorRelay<UIColor>
        let isWatched: BehaviorRelay<Bool>
    }
    
    let input = Input(invited: PublishSubject<Void>(),
                      dueDateTapped: PublishSubject<Void>(),
                      name: BehaviorRelay<String>(value: ""),
                      description: BehaviorRelay<String>(value: ""),
                      checkListTapped: PublishSubject<Void>(),
                      attachmentsTapped: PublishSubject<Void>(),
                      watchTapped: PublishSubject<Void>())
    
    let output = Output(createEnabled: BehaviorRelay<Bool>(value: false),
                        createTextColor: BehaviorRelay<UIColor>(value: UIColor.white),
                        createBackgroundColor: BehaviorRelay<UIColor>(
                            value: UIColor(Theme.Color.disabledButtonBackgroundColor)!),
                        isWatched: BehaviorRelay<Bool>(value: false))
    
    override init() {
        super.init()
        
        input.invited
            .subscribe(onNext: { [unowned self] _ in
                self.navigator.push(scene: .invite(viewModel: InviteViewModel()))
            })
            .disposed(by: disposeBag)
        
        input.dueDateTapped
            .subscribe(onNext: { _ in
                Logger.log("AddTaskViewModel dueDate Button tapped", .verbose)
            })
            .disposed(by: disposeBag)
        
        input.checkListTapped
            .subscribe(onNext: { _ in
                Logger.log("AddTaskViewModel checkList Button tapped", .verbose)
            })
            .disposed(by: disposeBag)
        
        input.attachmentsTapped
            .subscribe(onNext: { _ in
                Logger.log("AddTaskViewModel attachments Button tapped", .verbose)
            })
            .disposed(by: disposeBag)
        
        input.watchTapped
            .asDriver(onErrorJustReturn: ())
            .map { !(self.output.isWatched.value) }
            .drive(output.isWatched)
            .disposed(by: disposeBag)

        Driver
            .combineLatest(
                input.name.asDriver().map { $0 != "" },
                input.description.asDriver().map { $0 != "" })
            .map { $0 && $1 }
            .drive(output.createEnabled).disposed(by: disposeBag)
            
        let createEnabledDriver = output.createEnabled.asDriver()
        
        createEnabledDriver
            .map { $0 ? UIColor(Theme.Color.primary_dark)! : .white }
            .drive(output.createTextColor)
            .disposed(by: disposeBag)
        
        createEnabledDriver
            .map { $0 ?
                UIColor(Theme.Color.enabledButtonBackgroundColor) ?? .red:
                UIColor(Theme.Color.disabledButtonBackgroundColor) ?? .red }
            .drive(output.createBackgroundColor)
            .disposed(by: disposeBag)
    }
}
