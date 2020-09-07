//
//  NotificationsCell.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class NotificationsCell: TableViewCell {
    
    @IBOutlet weak var userImageView: ImageView!
    @IBOutlet weak var userNameAndActionLabel: Label!
    @IBOutlet weak var taskNameLabel: Label!
    @IBOutlet weak var timestampLabel: Label!
    
    public var vm: NotificationCellViewModel? {
        didSet {
            
            userNameAndActionLabel.text = "\(vm?.userName ?? "") \(vm?.action ?? "")"
            taskNameLabel.text = vm?.taskName
            if let timestamp = vm?.timestamp {
                timestampLabel.text = Date.timeIntervalChangeToTimeStr(timeInterval: timestamp,
                                                                    dateFormat: "MM-dd HH:mm")
            } else {
                Logger.log("Timestamp is null", .warn)
            }
        }
    }
    
    public var avatarTapped: Observable<Void> {
        return self.userImageView.rx.tapGesture
    }
    
}
