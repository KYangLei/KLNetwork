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

public enum KLNetworkDownloadStatus {
    case downloadFail
    case downloadComplete
}

public enum KLNetworkUploadStatus {
    case uploadFail
    case uploadComplete
}


public typealias KLNetworkRequestSuccess = (_ response: JSON) -> Void
public typealias KLNetworkRequestFailure = (_ error:Any) -> Void
public typealias KLNetworkProgress = (_ bytesRead:Int64,_ totalBytes:Int64) -> Void
public typealias KLNetworkDownloadResult = (_ filePath:String?,_ status:KLNetworkDownloadStatus) -> Void
public typealias KLNetworkUploadResult = (_ status:KLNetworkUploadStatus) -> Void
public typealias KLNetworkReachabilityListener = (_ status: KLNetworkReachabilityStatus) -> Void

class KLUploadParams: NSObject {
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
    var mineType:String!
    /**
     *  如果是图片，则上传的图片压缩比例（0 - 1）浮点型
     */
    var quality:CGFloat!
}
