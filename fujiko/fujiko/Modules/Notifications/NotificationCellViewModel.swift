//
//  NotificationCellViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

final class NotificationCellViewModel {
    
    let userImage: String
    let userName: String
    let taskName: String
    let action: String
    let timestamp: TimeInterval
    
    init(notification: Notification) {
        userName = notification.userName ?? ""
        userImage = notification.userImage ?? ""
        taskName = notification.taskName ?? ""
        action = notification.action ?? ""
        timestamp = notification.timestamp ?? 0
    }

}
