//
//  AddProjectViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

final class AddProjectViewController: ViewController<AddProjectViewModel> {

    @IBOutlet weak var projectNameTextField: TextField!
    @IBOutlet weak var peopleTextField: TextField!
    @IBOutlet weak var projectDescriptionTextView: TextView!
    @IBOutlet weak var addTaskButton: Button!
    @IBOutlet weak var createButton: Button!
    
    override func makeUI() {
            
        title = R.string.i18n.add_project()
        
        let dismissButtonItem: UIBarButtonItem = {
            let dismissButton = Button(type: .custom)
            dismissButton.backgroundColor = UIColor(Theme.Color.background_blue)
            dismissButton.rx.tap
                .asDriver()
                .drive(vm.input.dismissed)
                .disposed(by: disposeBag)
            dismissButton.setTitle(R.string.i18n.dismiss(), for: .normal)
            dismissButton.setTitleColor(.black, for: .normal)
            dismissButton.titleLabel?.font = R.font.poppinsRegular(size: 16)
            dismissButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
            dismissButton.layer.cornerRadius = 3
            dismissButton.layer.masksToBounds = true
            return UIBarButtonItem(customView: dismissButton)
        }()
        self.navigationItem.rightBarButtonItem = dismissButtonItem
        
        view.rx.tapGesture
            .subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
        
    }
    
    override func bindViewModel() {
        
        projectNameTextField.rx.value
            .orEmpty
            .asDriver()
            .drive(vm.input.name)
            .disposed(by: disposeBag)
        
        projectDescriptionTextView.rx.value.orEmpty
            .asDriver()
            .drive(vm.input.description)
            .disposed(by: disposeBag)
        
        peopleTextField.rx.tapGesture
            .asDriver(onErrorJustReturn: ())
            .drive(vm.input.invited)
            .disposed(by: disposeBag)
        
        addTaskButton.rx.tap
            .asDriver()
            .drive(vm.input.taskStarted)
            .disposed(by: disposeBag)

        vm.output.createEnabled
            .asDriver()
            .drive(createButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        vm.output.createTextColor
            .asDriver()
            .drive(createButton.rx.titleColor)
            .disposed(by: disposeBag)
        
        vm.output.createBackgroundColor
            .asDriver()
            .drive(createButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        if let scrollView = view as? ScrollView {
            
            scrollView.isScrollEnabled = true
            RxKeyboard.instance.visibleHeight
            .drive(onNext: { [scrollView] keyboardVisibleHeight in
                scrollView.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
            
        } else {
            Logger.log("Root View in AddProjectViewController is not a ScrollView", .warn)
        }

    }
}
