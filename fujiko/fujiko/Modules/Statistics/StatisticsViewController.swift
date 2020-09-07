//
//  StatisticsViewController.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

final class StatisticsViewController: ViewController<StatisticsViewModel> {
    
    @IBOutlet weak var inProgressItemView: StatisticsItemView!
    @IBOutlet weak var completedItemView: StatisticsItemView!
    @IBOutlet weak var todoItemView: StatisticsItemView!
    @IBOutlet weak var inReviewItemView: StatisticsItemView!
    @IBOutlet weak var barChartView: BarChartView!
    
    override func makeUI() {
        
        title = R.string.i18n.statistics()
        
        // Settings Button
        let settingsButtonItem: UIBarButtonItem = {
            let settingsButton = Button(type: .custom)
            settingsButton.rx.tap.asDriver().drive(vm.input.settingsTapped).disposed(by: disposeBag)
            settingsButton.setImage(R.image.settings()?.byResize(to: CGSize(width: 30, height: 30)), for: .normal)
            return UIBarButtonItem(customView: settingsButton)
        }()
        self.navigationItem.leftBarButtonItem = settingsButtonItem
        
        // Notifications Button
        let notificationsButtonItem: UIBarButtonItem = {
            let notificationsButton = Button(type: .custom)
            notificationsButton.setImage(R.image.notifications()?
                .byResize(to: CGSize(width: 35, height: 35)), for: .normal)
            notificationsButton.rx.tap.asDriver().drive(vm.input.notificationsTapped).disposed(by: disposeBag)
            return UIBarButtonItem(customView: notificationsButton)
        }()
        self.navigationItem.rightBarButtonItem = notificationsButtonItem
        
        inProgressItemView.choose(status: true)
        
    }
    
    override func bindViewModel() {
        
        let combinedChosen = Observable.merge(
            inProgressItemView.rx.tapGesture.map { StatisticsStatus.in_progress },
            completedItemView.rx.tapGesture.map { StatisticsStatus.completed },
            todoItemView.rx.tapGesture.map { StatisticsStatus.to_do },
            inReviewItemView.rx.tapGesture.map { StatisticsStatus.in_review })

        combinedChosen
            .startWith(.in_progress)
            .distinctUntilChanged()
            .pairwise()
            .asDriver(onErrorJustReturn: (.in_progress, .in_progress))
            .do(onNext: { arg0 in

                let (oldStatisticsStatus, newStatisticsStatus) = arg0
                print(oldStatisticsStatus)
                print(newStatisticsStatus)
                switch newStatisticsStatus {
                case .in_progress:
                    self.inProgressItemView.choose(status: true)
                case .completed:
                    self.completedItemView.choose(status: true)
                case .to_do:
                    self.todoItemView.choose(status: true)
                case .in_review:
                    self.inReviewItemView.choose(status: true)
                }

                switch oldStatisticsStatus {
                case .in_progress:
                    self.inProgressItemView.choose(status: false)
                case .completed:
                    self.completedItemView.choose(status: false)
                case .to_do:
                    self.todoItemView.choose(status: false)
                case .in_review:
                    self.inReviewItemView.choose(status: false)
                }
            })
            .map { $0.1 }
            .drive(vm.input.loadStatisticsStarted)
            .disposed(by: disposeBag)

        vm.output.statistics
            .asDriver()
            .drive(barChartView.statistics)
            .disposed(by: disposeBag)
        
    }
        
}
