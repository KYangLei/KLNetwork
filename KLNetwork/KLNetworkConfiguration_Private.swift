//
//  KLNetworkConfiguration_Private.swift
//  KLNetwork
//
//  Created by Kuroba.Lei on 2018/6/11.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

import UIKit

private var versionPrivate: String?
var PY_Version: String {
    get {
        if let versionPrivate_ = versionPrivate {
            return versionPrivate_
        }
        versionPrivate = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        return versionPrivate ?? "没有version😁"
    }
}


/**
 * log 在release 版本不打印
 * 注意要在 项目的 budSeting中 查找 `Other Swift Flags`，修改debug模式的flag 为“DEBUG”
 */
func dPrint(_ item: @autoclosure () -> Any) {
    if isDebug || isPrintSucceedData{
        print(item())
    }
}

///是否为debug模式
var isDebug: Bool {
    get {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
class AlamofireConfiguration_Private: NSObject {
    
}
