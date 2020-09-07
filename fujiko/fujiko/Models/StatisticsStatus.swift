//
//  StatisticsStatus.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

enum StatisticsStatus: String {
    case in_progress = "IN PROGRESS"
    case completed = "COMPLETED"
    case to_do = "TO DO"
    case in_review = "IN REVIEW"
}

extension StatisticsStatus {
    
    func toNumber() -> Int {
        switch self {
        case .in_progress:
            return 0
        case .completed:
            return 1
        case .to_do:
            return 2
        case .in_review:
            return 3
        }
    }
}

extension Int {
    func toStatisticsStatus() -> StatisticsStatus {
        switch self {
        case 0:
            return StatisticsStatus.in_progress
        case 1:
            return StatisticsStatus.completed
        case 2:
            return StatisticsStatus.to_do
        case 3:
            return StatisticsStatus.in_review
        default:
            return StatisticsStatus.in_progress
        }
    }
}
