//
//  TaskCell.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TaskCell: TableViewCell {
    
    @IBOutlet weak var taskNameLabel: Label!
    @IBOutlet weak var moreButton: Button!
    @IBOutlet weak var attachmentsButton: Button!
    @IBOutlet weak var viewButton: Button!
    @IBOutlet weak var timestampButton: Button!
    
    public var vm: TaskCellViewModel? {
        didSet {
            
            taskNameLabel.text = vm?.name
            attachmentsButton.setTitle("11", for: .normal)
            viewButton.setTitle("12", for: .normal)
            if let timestamp = vm?.timestamp {
                timestampButton.setTitle(
                    Date.timeIntervalChangeToTimeStr(timeInterval: timestamp, dateFormat: "MM-dd HH:mm"), for: .normal)
            } else {
                Logger.log("timestamp is null", .warn)
            }
        }
    }
    
}
