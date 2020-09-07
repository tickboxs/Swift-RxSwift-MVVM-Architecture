//
//  Weekday.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

enum Weekday {
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

extension Weekday {
    func toString() -> String {
        switch self {
        case .monday:
            return "M"
        case .tuesday:
            return "T"
        case .wednesday:
            return "W"
        case .thursday:
            return "T"
        case .friday:
            return "F"
        case .saturday:
            return "S"
        case .sunday:
            return "S"
        }
    }
    
    func toNumber() -> Int {
        switch self {
        case .monday:
            return 0
        case .tuesday:
            return 1
        case .wednesday:
            return 2
        case .thursday:
            return 3
        case .friday:
            return 4
        case .saturday:
            return 5
        case .sunday:
            return 6
        }
    }
}

extension Int {
    func toWeekday() -> Weekday {
        switch self {
        case 0:
            return Weekday.monday
        case 1:
            return Weekday.tuesday
        case 2:
            return Weekday.wednesday
        case 3:
            return Weekday.thursday
        case 4:
            return Weekday.friday
        case 5:
            return Weekday.saturday
        case 6:
            return Weekday.sunday
        default:
            return Weekday.monday
        }
    }
}
