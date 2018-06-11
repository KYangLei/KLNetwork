//
//  KLNetworkDefine.swift
//  KLNetwork
//
//  Created by 雷珂阳 on 2017/12/28.
//  Copyright © 2017年 雷珂阳. All rights reserved.
//

import UIKit

///域名 配置
//let baseServerWord = "test"
//var baseServerWord = "demo"

/// release模式 是哪个环境,一定要写对，
let baseServerWord_release = "api"

///debug模式 下默认是什么环境
var baseServerWord_debug: String = "demo"

var baseURL: String {
    get {
        if !isDebug {
            return "http://\(baseServerWord_release)/api/"
        }
        return "http://\(baseServerWord_debug)/api/"
    }
}


//MARK: - code 的处理

///code 处理 是否打印Log日志
let isPrintSucceedNetWorkLog: Bool = true
///是否打印失败请求
let isPrintErrorNetWorkLog: Bool = true
///是否打印请求成功后的数据
let isPrintSucceedData: Bool = true
///code处理的类 更改这里 全局配置code 的处理类
let k_codeMenager: KLNetworkRespnseCodeMenager.Type = KRCodeHandler.self

//MARK: - 超时时间
///超时时间
let Alamafire_TimeoutIntervalForRequest:TimeInterval = 20
let requestErrorMsg = "连接服务器失败，请稍后再试"
let notNetworkMsg = "没有网络连接，请稍后再试"

//MARK: - 所有请求都会带的东西比如 版本和 cookie
var Alamofire_header: [String:String]? {
    get {
        return [
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJQQVNTV09SRCI6IjEyMzQ1NiIsIlVTRVJfTkFNRSI6IjE1ODI4MDYxNzEwIiwiZXhwIjoxNTI5MzA1ODQ1fQ.JjbRZnErZZcC15nqDAy1ezcHiVjrPt6nRssLaK9ujBw":"Authorization"
        ]
    }
}

public enum KLNetworkReachabilityStatus {
    case notReachable
    case unknown
    case ethernetOrWiFi
    case wwan
}

public enum KLNetworkDownloadStatus {
    case downloadFail
    case downloadComplete
}

public enum KLNetworkUploadStatus {
    case uploadFail
    case uploadComplete
}


public typealias KLNetworkRequestSuccess = (_ response: [String:AnyObject]) -> Void
public typealias KLNetworkRequestFailure = (_ error:Any) -> Void
public typealias KLNetworkProgress = (_ bytesRead:Int64,_ totalBytes:Int64) -> Void
public typealias KLNetworkDownloadResult = (_ filePath:String?,_ status:KLNetworkDownloadStatus) -> Void
public typealias KLNetworkUploadResult = (_ status:KLNetworkUploadStatus) -> Void
public typealias KLNetworkReachabilityListener = (_ status: KLNetworkReachabilityStatus) -> Void

public class KLUploadParams: NSObject {
    /**
     *  上传文件的二进制数据
     */
    var data:Data!
    /**
     *  上传的参数名称
     */
    var paramKey:String!
    /**
     *  上传到服务器的文件名称
     */
    var fileName:String!
    /**
     *  上传文件的类型
     */
    var mineType:String! = "image/png"
    /**
     *  如果是图片，则上传的图片压缩比例（0 - 1）浮点型
     */
    var quality:CGFloat! = 0.5
}
