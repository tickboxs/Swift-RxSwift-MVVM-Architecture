//
//  SystemService.swift
//  fujiko
//
//  Created by Charlie Cai on 17/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation

class SystemService: ISystemService {
    func call(number: String) {
        
        guard let url = URL(string: "tel:" + number) else {
            Logger.log("Invalid Url", .error)
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
