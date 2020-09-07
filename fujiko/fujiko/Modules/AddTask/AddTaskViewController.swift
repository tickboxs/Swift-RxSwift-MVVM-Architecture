//
//  TaskViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

final class AddTaskViewController: ViewController<AddTaskViewModel> {

    @IBOutlet weak var taskNameTextField: TextField!
    @IBOutlet weak var assigneeTextField: TextField!
    @IBOutlet weak var dueDateTextField: TextField!
    @IBOutlet weak var taskDescriptionTextView: TextView!
    @IBOutlet weak var addChecklistButton: Button!
    @IBOutlet weak var addAttachmentButton: Button!
    @IBOutlet weak var watchButton: Button!
    @IBOutlet weak var createButton: Button!
    
    override func makeUI() {
        
        title = R.string.i18n.add_task()
        
        view.rx.tapGesture
            .subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        
        taskNameTextField.rx.value
            .orEmpty
            .asDriver()
            .drive(vm.input.name)
            .disposed(by: disposeBag)
        
        taskDescriptionTextView.rx.value
            .orEmpty
            .asDriver()
            .drive(vm.input.description)
            .disposed(by: disposeBag)
        
        dueDateTextField.rx.tapGesture
            .asDriver(onErrorJustReturn: ())
            .drive(vm.input.dueDateTapped)
            .disposed(by: disposeBag)
        
        assigneeTextField.rx.tapGesture
            .asDriver(onErrorJustReturn: ())
            .drive(vm.input.invited)
            .disposed(by: disposeBag)
        
        addChecklistButton.rx.tap
            .asDriver()
            .drive(vm.input.checkListTapped)
            .disposed(by: disposeBag)
        
        addAttachmentButton.rx.tap
            .asDriver()
            .drive(vm.input.attachmentsTapped)
            .disposed(by: disposeBag)
        
        watchButton.rx.tap
            .asDriver()
            .drive(vm.input.watchTapped)
            .disposed(by: disposeBag)
        
        let isWatchedDriver = vm.output.isWatched.asDriver()
        
        isWatchedDriver
            .map { $0 ? R.image.watch_selected() : R.image.watch_unselected() }
            .drive(watchButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
        
        isWatchedDriver
            .map { $0 ? .black : UIColor("#DEDEDE") ?? .red }
            .drive(self.watchButton.rx.titleColor)
            .disposed(by: disposeBag)
        
        vm.output.createEnabled
            .asDriver()
            .drive(createButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        vm.output.createTextColor
            .asDriver(onErrorJustReturn: .white)
            .drive(createButton.rx.titleColor)
            .disposed(by: disposeBag)
        
        vm.output.createBackgroundColor
            .asDriver(onErrorJustReturn: UIColor(Theme.Color.disabledButtonBackgroundColor) ?? .red)
            .drive(createButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        if let scrollView = view as? ScrollView {
            RxKeyboard.instance.visibleHeight
            .drive(onNext: { [scrollView] keyboardVisibleHeight in
              scrollView.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
        } else {
            Logger.log("Root View in AddTaskViewController is not a ScrollView", .warn)
        }
            
    }
    
}
