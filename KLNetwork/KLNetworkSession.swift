//
//  KLNetworkSession.swift
//  KLNetwork
//
//  Created by Kuroba.Lei on 2018/6/11.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

import UIKit
import Alamofire

///请求方式
enum RequestMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

/// 参数拼接的类型
enum ParamaetersType: String {
    case body = "body"
    case query = "query"
}

/// 请求 数据类型
enum ResponseDateType: String {
    case array = "array"
    case object = "Object"
    case json = "json"
}

class AlamofireSession: NSObject {
    static let `default`: AlamofireSession = AlamofireSession()
    /// 请求数据的 Menager
    var sessionMenager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = TimeInterval(Alamafire_TimeoutIntervalForRequest)
        
        let sessionMenager = SessionManager.init(configuration: configuration, delegate: KLNetworkSessionDelegate(), serverTrustPolicyManager: nil)
        
        return sessionMenager
    }()
}
