//
//  User.swift
//  fujiko
//
//  Created by Charlie Cai on 11/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    
    var role: String?
    var team: String?
    @EmailPW var email: String?
    var avatar: String?
    var status: UserStatus?
    var chat: Bool? = true
    var call: Bool? = true
    var reminders: Bool? = true
    var notifications: Bool? = true
    var darkMode: Bool? = true
    @UnixTimestampPW var signUpTimestamp: TimeInterval?
}

extension User: Jsonable {
    
    init(json: JSON) {
        self.role            = json["role"].string
        self.team            = json["team"].string
        self.email           = json["email"].string
        self.avatar          = json["avatar"].string
        self.status          = json["status"].int?.toUserStatus()
        self.chat            = json["chat"].bool
        self.call            = json["chat"].bool
        self.reminders       = json["reminders"].bool
        self.notifications   = json["notifications"].bool
        self.darkMode        = json["darkMode"].bool
        self.signUpTimestamp = json["signUpTimestamp"].double
    }
    
    func toJSON() -> [String: Any?] {

        return [
            "role": self.role,
            "team": self.team,
            "email": self.email,
            "avatar": self.avatar,
            "status": self.status?.toNumber(),
            "chat": self.chat,
            "call": self.call,
            "reminders": self.reminders,
            "notifications": self.notifications,
            "darkMode": self.darkMode,
            "signUpTimestamp": self.signUpTimestamp
        ]
    }
}
