//
//  StatisticsVM.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

// Statistics model viewModel wrapper because
// there is already a viewModel called StatisticsViewModel for StatisticsViewController
final class StatisticsVM {
    
    let weekday: Weekday
    let percentage: Float
    let status: StatisticsStatus
    
    init(statistics: Statistics) {
        weekday = statistics.weekday ?? .monday
        percentage = statistics.percentage ?? 0.0
        status = statistics.status ?? .in_progress
    }
}
