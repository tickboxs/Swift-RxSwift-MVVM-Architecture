//
//  Result.swift
//  fujiko
//
//  Created by Charlie Cai on 31/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

// 这里是模拟Rust的转换写法 Result类型
enum Result<T> {
    case Ok(v: T)
    case Err
    
    func expect(message: String) -> T {
        
        switch self {
        case .Ok(let v):
            return v
        case .Err:
            assertionFailure(message)
            return AnyObject.self as! T
        }
    }
    
    func compromise(v: T) -> T {
        switch self {
        case .Ok(let v):
            return v
        case .Err:
            return v
        }
    }
}
