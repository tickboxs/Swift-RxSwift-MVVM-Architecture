//
//  UserStatus.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

enum UserStatus: Int {
    
    case active = 0
    case inactive = 1
    case withdraw = 2
}

extension UserStatus {
    func toString() -> String {
        switch self {
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .withdraw:
            return "Withdraw"
        }
    }
    
    func toNumber() -> Int {
        switch self {
        case .active:
            return 0
        case .inactive:
            return 1
        case .withdraw:
            return 2
        }
    }
}

extension Int {
    func toUserStatus() -> UserStatus {
        switch self {
        case 0:
            return .active
        case 1:
            return .inactive
        case 3:
            return .withdraw
        default:
            return .withdraw
         }
    }
}
