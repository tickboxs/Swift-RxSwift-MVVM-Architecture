//
//  Task.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Task {
    var name: String?
    @UnixTimestampPW var timestamp: TimeInterval?
}

extension Task: Jsonable {
    
    init(json: JSON) {
        self.name      = json["name"].string
        self.timestamp = json["timestamp"].double
    }
    
    func toJSON() -> [String: Any?] {

        return [
            "name": self.name,
            "timestamp": self.timestamp
        ]
    }
    
}
