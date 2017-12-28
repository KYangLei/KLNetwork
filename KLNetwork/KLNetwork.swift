//
//  KLNetwork.swift
//  KLNetwork
//
//  Created by 雷珂阳 on 2017/12/28.
//  Copyright © 2017年 雷珂阳. All rights reserved.
//

import Foundation
import Alamofire
import KLProgressHUD
import KLStatusBar
import SwiftyJSON

public final class KLNetWork {
    public static let requestErrorMsg = "连接服务器失败，请稍后再试"
    private static let notNetworkMsg = "没有网络连接，请稍后再试"
    private static var globalHeaders: HTTPHeaders?
    
    private static func request(_ url: String, parameters: [String: Any]?, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?, method: HTTPMethod, headers: HTTPHeaders? = nil, isShowHUD: Bool = false, encoding: ParameterEncoding =  URLEncoding.default) {
        if KLNetWork.isReachable {
            if isShowHUD {
                KLProgressHUD.show()
            }
            Alamofire.request(url, method: method, parameters: parameters,encoding: encoding, headers: headers ?? self.globalHeaders).responseJSON { (response) in
                if isShowHUD {
                    KLProgressHUD.dismiss()
                }
                switch response.result {
                case .success(let value):
                    KLLog.debug((response.request!.url?.absoluteString)! + "\t******\tresponse:\r\(value)")
                    if success != nil {
                        let responseObject = JSON(value)
                        // 判断请求接口是否成功（api_code = 0）
                        if responseObject["code"].intValue  == 1 {
                            success!(responseObject)
                        }
                        else {
                          
                        }
                    }
                case .failure(let error):
                    KLLog.error((response.request!.url?.absoluteString)! + "\t******\terror:\r\(error.localizedDescription)")
                    KLProgressHUD.showError(requestErrorMsg)
                    if failure != nil {
                        failure!(error)
                    }
                }
            }
        }
        else {
            KLStatusBarNotification.showError(notNetworkMsg)
        }
    }
    
    //MARK: get
    public static func get(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .get, headers: headers, isShowHUD: false)
    }

    //MARK: get 显示 HUD
    public static func getWithShowHUD(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .get, headers: headers, isShowHUD: true)
    }
    
    //MARK: post
    public static func post(_ url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .post, headers: headers, isShowHUD: false)
    }
    
    //MARK: post 显示 HUD
    public static func postWithShowHUD(_ url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .post, headers: headers, isShowHUD: true)
    }
    
    //MARK: put
    public static func put(_ url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .put, headers: headers, isShowHUD: false)
    }
    
    //MARK: put 显示 HUD
    public static func putWithShowHUD(_ url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .put, headers: headers, isShowHUD: true)
    }
    
    //MARK: delete
    public static func delete(_ url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .delete, headers: headers, isShowHUD: false)
    }
    
    //MARK: delete 显示 HUD
    public static func deleteWithShowHUD(_ url: String, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .delete, headers: headers, isShowHUD: true)
    }
    
    //MARK: 设置全局 headers
    public static func setGlobalHeaders(_ headers: HTTPHeaders?) {
        self.globalHeaders = headers
    }
    
    static private var isStartNetworkMonitoring = true
    static private let networkManager = NetworkReachabilityManager(host: "www.qq.com")!
    //MARK: 网络监视
    public static func startNetworkMonitoring(listener: KLNetworkReachabilityListener? = nil) {
        networkManager.listener = { status in
            isStartNetworkMonitoring = true
            var klStatus = KLNetworkReachabilityStatus.notReachable
            switch status {
            case .notReachable:
                klStatus = KLNetworkReachabilityStatus.notReachable
            case .unknown:
                klStatus = KLNetworkReachabilityStatus.unknown
            case .reachable(.ethernetOrWiFi):
                klStatus = KLNetworkReachabilityStatus.ethernetOrWiFi
            case .reachable(.wwan):
                klStatus = KLNetworkReachabilityStatus.wwan
            }
            if listener != nil {
                listener!(klStatus)
            }
        }
        networkManager.startListening()
    }
    //MARK: 是否联网
    public static var isReachable: Bool {
        get {
            return isStartNetworkMonitoring ? networkManager.isReachable : true
        }
    }
    //MARK: 是否WiFi
    public static var isReachableWiFi: Bool {
        get {
            return networkManager.isReachableOnEthernetOrWiFi
        }
    }
    //MARK: 是否WWAN
    public static var isReachableWWAN: Bool {
        get {
            return networkManager.isReachableOnWWAN
        }
    }
}
