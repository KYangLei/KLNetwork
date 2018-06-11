//
//  KLNetworkURLManager.swift
//  KLNetwork
//
//  Created by Kuroba.Lei on 2018/6/11.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

import UIKit
import Alamofire
class KLNetworkURLManager: NSObject {
    
    private class func getBaseURLStr(_ str: String) -> (String) {
        return baseURL + str
    }
    ///返回一个url 并且 cach处理
    class func getURL(_ path:String) throws -> URL {
        var urlStr = KLNetworkURLManager.getBaseURLStr(path)
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        guard let URL = URL(string: urlStr) else { throw AFError.invalidURL(url: urlStr) }
        return URL
    }
}
