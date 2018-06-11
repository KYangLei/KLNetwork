//
//  KLNetworkSessionDelegate.swift
//  KLNetwork
//
//  Created by Kuroba.Lei on 2018/6/11.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

import UIKit
import Alamofire
class KLNetworkSessionDelegate: SessionDelegate {
    override func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        
    }
    override func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        sessionDidFinishEventsForBackgroundURLSession?(session)
    }
}
