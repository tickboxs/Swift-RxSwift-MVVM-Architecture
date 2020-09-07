//
//  Logger.swift
//  fujiko
//
//  Created by Charlie Cai on 22/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import CocoaLumberjack

//DDLogVerbose("Verbose")
//DDLogDebug("Debug")
//DDLogInfo("Info")
//DDLogWarn("Warn")
//DDLogError("Error")

enum LogLevel {
    case verbose
    case debug
    case info
    case warn
    case error
}

final class Logger {
    
    static func initialize() {
        
        // Set Logger
        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
            
        //DDLogVerbose("Verbose")
        //DDLogDebug("Debug")
        //DDLogInfo("Info")
        //DDLogWarn("Warn")
        //DDLogError("Error")
    }
    
    static func log<T>(_ message: T, file: String = #file, funcName: String = #function,
                       lineNum: Int = #line, _ logLevel: LogLevel = .verbose) {
        
        let file = (file as NSString).lastPathComponent
        
        #if DEBUG
        print("\(file):(\(lineNum))--\(message)")
        #elseif RELEASE
        switch logLevel {
        case .verbose:
            DDLogVerbose(message)
        case .debug:
            DDLogDebug(message)
        case .info:
            DDLogInfo(message)
        case .warn:
            DDLogWarn(message)
        case .error:
            DDLogError(message)
        }
        #endif
        
    }
}
