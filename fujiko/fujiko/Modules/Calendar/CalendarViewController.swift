//
//  CalendarViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import YYKit
import Rswift
import RxCocoa
import JTAppleCalendar

final class CalendarViewController: ViewController<CalendarViewModel> {
    
    @IBOutlet weak var calendarHeaderView: CalendarHeaderView!
    @IBOutlet weak var calendarView: CalendarView!
    
    override func makeUI() {
        
        title = R.string.i18n.calendar()
        
        // Setting Button
        let settingsButtonItem: UIBarButtonItem = {
            let settingsButton = Button(type: .custom)
            settingsButton.rx.tap
                .asDriver()
                .drive(vm.input.settingsTapped)
                .disposed(by: disposeBag)
            settingsButton
                .setImage(R.image.settings()?
                .byResize(to: CGSize(width: 30, height: 30)), for: .normal)
            return UIBarButtonItem(customView: settingsButton)
        }()
        self.navigationItem.leftBarButtonItem = settingsButtonItem
        
        // Search Button
        let searchButtonItem: UIBarButtonItem = {
            let searchButton = Button(type: .custom)
            searchButton.rx.tap
                .asDriver()
                .drive(vm.input.searchTapped)
                .disposed(by: disposeBag)
            searchButton
                .setImage(R.image.search()?
                .byResize(to: CGSize(width: 30, height: 30)), for: .normal)
            return UIBarButtonItem(customView: searchButton)
        }()
        self.navigationItem.rightBarButtonItem = searchButtonItem
        
    }
    
    override func bindViewModel() {
        
        vm.output.dateRelay
            .asDriver()
            .map { (date) -> String in
                let formater = DateFormatter()
                formater.dateFormat="MMMM"
                return formater.string(from: date)
            }.map {
                $0.uppercased()
            }
            .drive(calendarHeaderView.rx.title)
            .disposed(by: disposeBag)
        
        calendarHeaderView.rx.previousTapped.map { SegmentDestination.previous }
            .merge(with:
                calendarHeaderView.rx.nextTapped.map { SegmentDestination.next })
            .asDriver(onErrorJustReturn: .previous)
            .drive(vm.input.previousNextTapped)
            .disposed(by: disposeBag)
        
        calendarView.rx.date.asDriver()
            .drive(vm.output.dateRelay)
            .disposed(by: disposeBag)
        
        vm.output.pageTranslation
            .asDriver(onErrorJustReturn: .previous)
            .drive(calendarView.rx.pageTranslation)
            .disposed(by: disposeBag)
    }
}
