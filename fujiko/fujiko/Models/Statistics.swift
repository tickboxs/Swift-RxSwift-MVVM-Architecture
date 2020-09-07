//
//  Statistics.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Statistics {
    var weekday: Weekday?
    @PercentagePW var percentage: Float?
    var status: StatisticsStatus?
}

extension Statistics: Jsonable {

    init(json: JSON) {
        weekday    = json["weekday"].int?.toWeekday()
        percentage = json["percentage"].float
        status     = json["status"].int?.toStatisticsStatus()
    }
    
    func toJSON() -> [String: Any?] {

        return [
            "weekday": self.weekday?.toNumber(),
            "percentage": self.percentage,
            "status": self.status?.toNumber()
        ]
    }
    
}
