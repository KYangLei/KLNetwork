//
//  KLLog.swift
//  KLNetwork
//
//  Created by 雷珂阳 on 2017/12/28.
//  Copyright © 2017年 雷珂阳. All rights reserved.
//

import UIKit

public enum KLLogLevel: Int {
    case off = 0
    case verbose = 1
    case debug = 2
    case info = 3
    case warn = 4
    case error = 5
}
typealias LogLevel = KLLogLevel

class KLLog {
    //MARK:日志级别
    private static var logLevel = LogLevel.error
    
    private static var verbosePrefix = "[verbose] - "
    private static var debugPrefix = "[debug] - "
    private static var infoPrefix = "[info] - "
    private static var warnPrefix = "[warn] - "
    private static var errorPrefix = "[error] - "
    private static var dateFormat: DateFormatter = {
        $0.dateFormat = "HH:mm:ss.SSS"
        return $0
    }(DateFormatter())
    
    public static func logLevel(_ level: KLLogLevel) {
        self.logLevel = level
    }
    
    public static func prefix(_ prefix: String, logLeve: KLLogLevel) {
        switch logLevel {
        case .verbose:
            self.verbosePrefix = prefix
        case .debug:
            self.debugPrefix = prefix
        case .info:
            self.infoPrefix = prefix
        case .warn:
            self.warnPrefix = prefix
        case .error:
            self.errorPrefix = prefix
        default: break
        }
    }
    
    public static func verbose(_ item: Any) {
        if self.logLevel.rawValue > LogLevel.off.rawValue && self.logLevel.rawValue >= LogLevel.verbose.rawValue {
            KLLog.log(prefix: self.verbosePrefix, item: item)
        }
    }
    
    public static func debug(_ item: Any) {
        if self.logLevel.rawValue > LogLevel.off.rawValue && self.logLevel.rawValue >= LogLevel.debug.rawValue {
            KLLog.log(prefix: self.debugPrefix, item: item)
        }
    }
    
    public static func info(_ item: Any) {
        if self.logLevel.rawValue > LogLevel.off.rawValue && self.logLevel.rawValue >= LogLevel.info.rawValue {
            KLLog.log(prefix: self.infoPrefix, item: item)
        }
    }
    
    public static func warn(_ item: Any) {
        if self.logLevel.rawValue > LogLevel.off.rawValue && self.logLevel.rawValue >= LogLevel.warn.rawValue {
            KLLog.log(prefix: self.warnPrefix, item: item)
        }
    }
    
    public static func error(_ item: Any) {
        if self.logLevel.rawValue > LogLevel.off.rawValue && self.logLevel.rawValue >= LogLevel.error.rawValue {
            KLLog.log(prefix: self.errorPrefix, item: item)
        }
    }
    
    private static func log(prefix: String, item: Any) {
        print("\(prefix)\(nowString):\t\(item)")
    }
    
    private static var nowString: String {
        get {
            return self.dateFormat.string(from: Date())
        }
    }
}

