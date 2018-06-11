//
//  KLNetworkManager.swift
//  KLNetwork
//
//  Created by Kuroba.Lei on 2018/6/11.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

import UIKit
import Alamofire

class KLNetworkManager: NSObject {
    static let sharedManager = KLNetworkManager()
    private var isStartNetworkMonitoring = true
    private let networkManager = NetworkReachabilityManager(host: "www.qq.com")!
    //MARK: 网络监视
    func startNetworkMonitoring(listener: KLNetworkReachabilityListener? = nil) {
        networkManager.listener = { status in
            self.isStartNetworkMonitoring = true
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
    var isReachable: Bool {
        get {
            return isStartNetworkMonitoring ? networkManager.isReachable : true
        }
    }
    //MARK: 是否WiFi
    var isReachableWiFi: Bool {
        get {
            return networkManager.isReachableOnEthernetOrWiFi
        }
    }
    //MARK: 是否WWAN
    var isReachableWWAN: Bool {
        get {
            return networkManager.isReachableOnWWAN
        }
    }
}
