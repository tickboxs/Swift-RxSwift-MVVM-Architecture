//
//  Date+Timestamp.swift
//  fujiko
//
//  Created by Charlie Cai on 15/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
extension Date {
    
    //unix timestamp to string
    static func timeIntervalChangeToTimeStr(timeInterval: TimeInterval, dateFormat: String?) -> String {
        let date: NSDate = NSDate.init(timeIntervalSince1970: timeInterval/1000)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    
    //string to unix timestamp string
    static func timeStrChangeTotimeInterval(timeStr: String?, dateFormat: String?) -> Result<TimeInterval> {
        if timeStr?.count ?? 0 <= 0 {
            return .Err
        }
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            format.dateFormat = dateFormat
        }
        let date = format.date(from: timeStr!)
        // return as 13 digits Unix Timestamp
        if let timestamp = date?.timeIntervalSince1970 {
            return .Ok(v: timestamp * TimeInterval(1000))
        } else {
            return .Err
        }
    }
}
