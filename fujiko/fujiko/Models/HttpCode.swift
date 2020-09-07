//
//  HttpCode.swift
//  fujiko
//
//  Created by Charlie Cai on 10/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

enum HttpCode: Int {
    case ok = 0
    case error = 1
}

extension HttpCode {
    func toNumber() -> Int {
        switch self {
        case .ok:
            return 0
        case .error:
            return 1
        }
    }
}

extension Int {
    func toHttpCode() -> HttpCode {
        switch self {
        case 0:
            return HttpCode.ok
        case 1:
            return HttpCode.error
        default:
            return HttpCode.ok
        }
    }
}
