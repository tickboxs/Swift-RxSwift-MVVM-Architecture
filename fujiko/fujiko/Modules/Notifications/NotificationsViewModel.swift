//
//  NotificationsViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

final class NotificationsViewModel: ViewModel, ViewModelType {
    
    private let apiService = Container.shared.resolve(IApiService.self)!
    
    struct Input {
        let loadNotificationsStarted: BehaviorRelay<Void>
        let avatarTapped: PublishSubject<Void>
    }
    
    struct Output {
        let notifications: BehaviorRelay<[NotificationCellViewModel]>
        let refreshing: BehaviorRelay<Bool>
    }
    
    let input = Input(loadNotificationsStarted: BehaviorRelay<Void>(value: ()),
                      avatarTapped: PublishSubject<Void>())
    let output = Output(notifications: BehaviorRelay<[NotificationCellViewModel]>(value: []),
                        refreshing: BehaviorRelay<Bool>(value: false))
    
    override init() {
        super.init()
        
        input.loadNotificationsStarted
            .do(onNext: { [unowned self] _ in self.output.refreshing.accept(true) })
            .flatMapLatest { [unowned self] _ in self.apiService.getAllNotifications() }
            .do(onNext: { [unowned self] _ in self.output.refreshing.accept(false) })
            .map { (response) -> [Notification] in
                if response.code == .ok { return response.data ?? [] } else { return [] }}
            .map { (notifications) -> [NotificationCellViewModel] in
                return notifications.map { (notification) -> NotificationCellViewModel in
                    return NotificationCellViewModel(notification: notification)
                }}
            .asDriver(onErrorJustReturn: [])
            .drive(output.notifications)
            .disposed(by: disposeBag)
        
        input.avatarTapped
            .subscribe(onNext: { [unowned self] _ in
                self.navigator.push(scene: .userDetail(viewModel: UserDetailViewModel(userId: 10)))
            })
            .disposed(by: disposeBag)

    }
}
