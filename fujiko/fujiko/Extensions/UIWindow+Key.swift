//
//  UIWindow+Key.swift
//  fujiko
//
//  Created by Charlie Cai on 16/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

extension UIWindow {
    static let keyWindow = UIApplication.shared.windows.filter({ (window) -> Bool in
        return window.isKeyWindow
    }).first
}
