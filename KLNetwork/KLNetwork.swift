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
//            KLNetWork.setGlobalHeaders(["token":"53be4919-6c40-4ecd-8253-a9c47ec248f5"])
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
                        if responseObject["code"].intValue  == 200 {
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
    
    private static func downloadRequest(_ url: String, toPath:String?, parameters: [String: Any]?,downloadProgress:KLNetworkProgress?, downloadResult: KLNetworkDownloadResult?, isShowHUD: Bool = false) {
        if KLNetWork.isReachable {
            let destination: DownloadRequest.DownloadFileDestination = { _, response in
                if toPath != nil {
                    //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
                    return (URL.init(fileURLWithPath: toPath!), [.removePreviousFile, .createIntermediateDirectories])
                }
                else {
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
                    //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
                    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                }
            }
            //开始下载
            Alamofire.download(url, to: destination).downloadProgress(closure: { (progress) in
                print(progress.completedUnitCount,progress.totalUnitCount)
                
                downloadProgress!(progress.completedUnitCount, progress.totalUnitCount)
                if isShowHUD {
                    KLProgressHUD.showProgress(CGFloat(progress.fractionCompleted))
                }
            }).response { response in
//                print(response)
                KLProgressHUD.dismiss()
                let filePath = response.destinationURL?.path
                let error = response.error
                if error == nil {
                    downloadResult!(filePath!,KLNetworkDownloadStatus.downloadComplete)
                }
                else {
                    downloadResult!("",KLNetworkDownloadStatus.downloadFail)
                }
            }
        }
        else {
            KLStatusBarNotification.showError(notNetworkMsg)
        }
    }
    
    private static func uploadRequest(_ imageArray:[KLUploadParams],hostURL:String, parameters: [String: Any]?,uploadProgress:KLNetworkProgress?, uploadResult: KLNetworkUploadResult?, isShowHUD: Bool = false) {
        if KLNetWork.isReachable {
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for param in imageArray {
                    multipartFormData.append(param.data, withName: param.paramKey, fileName: param.fileName, mimeType: param.mineType)
                }
            }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: hostURL, method: .post, headers: self.globalHeaders, encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(let request, _, _):
                    request.uploadProgress(closure: { (progress) in
                        KLProgressHUD.showProgress(CGFloat(progress.fractionCompleted))
                        if uploadProgress != nil {
                            uploadProgress!(progress.completedUnitCount, progress.totalUnitCount)
                        }
                    })
                    request.responseJSON(completionHandler: { (response) in
                        KLProgressHUD.dismiss()
                        switch response.result {
                        case .success(let value):
                            KLLog.debug((response.request!.url?.absoluteString)! + "\t******\tresponse:\r\(value)")
                            uploadResult!(KLNetworkUploadStatus.uploadComplete)
                        case .failure(let error):
                            KLLog.error((response.request!.url?.absoluteString)! + "\t******\terror:\r\(error.localizedDescription)")
                            uploadResult!(KLNetworkUploadStatus.uploadFail)
                        }
                    })
                case .failure(let error):
                    KLProgressHUD.dismiss()
                    KLProgressHUD.showError("上传文件编码错误\(error.localizedDescription)")
                    print(error.localizedDescription)
                }
            })
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
    public static func post(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .post, headers: headers, isShowHUD: false)
    }
    
    //MARK: post 显示 HUD
    public static func postWithShowHUD(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .post, headers: headers, isShowHUD: true)
    }
    
    //MARK: put
    public static func put(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .put, headers: headers, isShowHUD: false)
    }
    
    //MARK: put 显示 HUD
    public static func putWithShowHUD(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .put, headers: headers, isShowHUD: true)
    }
    
    //MARK: delete
    public static func delete(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .delete, headers: headers, isShowHUD: false)
    }
    
    //MARK: delete 显示 HUD
    public static func deleteWithShowHUD(_ url: String, parameters: [String: Any]?, headers: HTTPHeaders? = nil, success: KLNetworkRequestSuccess?, failure: KLNetworkRequestFailure?) {
        request(url, parameters: parameters, success: success, failure: failure, method: .delete, headers: headers, isShowHUD: true)
    }
    
    //MARK: downlad 显示 HUD 简单的单个文件下载
    public static func downloadWithShowHUD(_ url: String, toPath:String?, parameters: [String: Any]?, progress: KLNetworkProgress?, result: KLNetworkDownloadResult?) {
        downloadRequest(url, toPath: toPath, parameters: parameters, downloadProgress: progress, downloadResult: result, isShowHUD: true)
    }
    
    //MARK: upload 显示 HUD 上传文件
    public static func uploadWithShowHUD(_ url: String, filesArray:[KLUploadParams], parameters: [String: Any]?, progress: KLNetworkProgress?, result: KLNetworkUploadResult?) {
        if filesArray.count > 0 {
            uploadRequest(filesArray, hostURL: url, parameters: parameters, uploadProgress: progress, uploadResult: result, isShowHUD: true)
        }
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
