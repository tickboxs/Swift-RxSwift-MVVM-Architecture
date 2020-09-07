//
//  Project.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Project {
    var name: String?
    var memebers: [User]?
    var description: String?
    var tasks: [Task]?
}

extension Project: Jsonable {
    
    init(json: JSON) {
        self.name         = json["name"].string
        self.memebers     = json["memebers"].array?.map { User(json: $0) }
        self.description  = json["description"].string
        self.tasks        = json["tasks"].array?.map { Task(json: $0) }
    }
    
    func toJSON() -> [String: Any?] {

        return [
            "name": self.name,
            "memebers": self.memebers?.map { $0.toJSON() },
            "description": self.description,
            "tasks": self.tasks?.map { $0.toJSON() }
        ]
    }
}
