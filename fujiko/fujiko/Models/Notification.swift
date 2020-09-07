//
//  Notification.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Notification {
    var userId: Int?
    var userImage: String?
    var userName: String?
    var taskName: String?
    var action: String?
    @UnixTimestampPW var timestamp: TimeInterval?
}

extension Notification: Jsonable {
    
    init(json: JSON) {
        self.userId    = json["userId"].int
        self.userImage = json["userImage"].string
        self.userName  = json["userName"].string
        self.taskName  = json["taskName"].string
        self.action    = json["action"].string
        self.timestamp = json["timestamp"].double
    }
    
    func toJSON() -> [String: Any?] {

        return [
            "userId": self.userId,
            "userImage": self.userImage,
            "userName": self.userName,
            "taskName": self.taskName,
            "action": self.action,
            "timestamp": self.timestamp
        ]
    }
}
