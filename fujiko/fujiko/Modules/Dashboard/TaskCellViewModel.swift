//
//  TaskCellViewModel.swift
//  fujiko
//
//  Created by Charlie Cai on 16/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

final class TaskCellViewModel {
    
    let name: String
    let timestamp: TimeInterval
    
    init(task: Task) {
        name = task.name ?? ""
        timestamp = task.timestamp ?? 0
    }
}
