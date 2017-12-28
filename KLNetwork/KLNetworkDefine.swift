//
//  KLNetworkDefine.swift
//  KLNetwork
//
//  Created by 雷珂阳 on 2017/12/28.
//  Copyright © 2017年 雷珂阳. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum KLNetworkReachabilityStatus {
    case notReachable
    case unknown
    case ethernetOrWiFi
    case wwan
}

public typealias KLNetworkRequestSuccess = (_ response: JSON) -> Void
public typealias KLNetworkRequestFailure = (_ error:Any) -> Void
public typealias KLNetworkReachabilityListener = (_ status: KLNetworkReachabilityStatus) -> Void
