//
//  KLNetworkRespnseCodeMenager.swift
//  KLNetwork
//
//  Created by Kuroba.Lei on 2018/6/11.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireObjectMapper
//import ObjectMapper

public class KLNetworkRespnseCodeMenager: NSObject {
    ///继承这个这个类，并且 重写这个函数 来处理 code
    class func custom_handCodeFunc(_ code: NSInteger, _ netData: Any?, _ error: Error?, _ url: URL?) {}
    
    ///继承这个这个类，并且 重写这个函数 来处理 成功code
    class func custom_handSucceedCodeFunc(_ netData: Any?, _ url: URL?) {}
    
    ///继承这个这个类，并且 重写这个函数 来处理 失败code
    class func custom_handDefeatCodeFunc(_ code: NSInteger,_ error: Error?, _ url: URL?) {}
    
    ///code log  处理
    class func handleCode (_ code: NSInteger, _ netData: Any?, _ error: Error?, _ url: URL?) -> (Bool) {
        custom_handCodeFunc(code, netData, error, url)
        if code / 100 == 2 {
            succeed(code,netData,url)
            custom_handSucceedCodeFunc(netData, url)
            return true
        }
        custom_handDefeatCodeFunc(code, error, url)
        defeat(code, error, url)
        return false
    }
}

/// log输出
private extension KLNetworkRespnseCodeMenager {
    
    class func succeed(_ code: NSInteger,_ netData: Any?, _ url: URL?) {
        if !isPrintSucceedNetWorkLog {
            return
        }
        let urlTemp: Any = url ?? "url 未知"
        let dataTemp: Any = netData ?? "data 未知"
        
        dPrint("\n\n✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅请求成功 code: \(code)\n✅\(urlTemp)\n")
        if let dataArray = (dataTemp as? Array<Any>) {
            dPrint("etData(Array):--")
            for data in dataArray {
                dPrint(data)
            }
            
        }else{
            dPrint(dataTemp)
            dPrint("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅\n\n\n")
        }
    }
    
    class func defeat(_ code: NSInteger,_ error: Error?, _ url: URL?) {
        if !isPrintErrorNetWorkLog {
            return
        }
        let urlTemp: Any = url ?? "url 未知"
        let errorTemp: Any = error ?? "error 未知"
        dPrint("\n\n🌶🌶🌶🌶🌶🌶🌶🌶🌶🌶🌶🌶请求失败 code：\(code)\n\(urlTemp)\n")
        dPrint("\n🌶error:--")
        dPrint(errorTemp)
        dPrint("🌶🌶🌶🌶🌶🌶🌶🌶🌶🌶🌶🌶\n\n\n\n")
    }
}
