//
//  KLNetworkHandler.swift
//  KLNetwork
//
//  Created by Kuroba.Lei on 2018/6/11.
//  Copyright © 2018年 雷珂阳. All rights reserved.
//

import UIKit
import Alamofire
import KLProgressHUD

class KLNetworkHandler: NSObject {
    static let sharedManager = KLNetworkHandler()
    ///code码处理 类
    var codeMenager: KLNetworkRespnseCodeMenager.Type = k_codeMenager
    ///请求错误的时候提示信息
    var errorShowMassage: String = ""
    
     //MARK: - 下载数据 相关接口
    /// alamofire 数据请求 (数据Json)
    ///注意循环引用
    /// - Parameters:
    ///   - path: url path
    ///   - method: 请求方式
    ///   - parameters: 参数
    ///   - parametersType: 参数为 query 还是 body
    ///   - responseDateType: 网络数据类型
    ///   - success: 成功的回调
    ///   - failure: 失败的回调
    /// - Returns: Request
    @discardableResult
    func loadData(Path path: String,showHud:Bool, HTTPMethod method: RequestMethod? = .get,_ parameters: [String:Any]? = nil,_ parametersType: ParamaetersType? = nil,Success success: @escaping KLNetworkRequestSuccess, Failure failure:@escaping KLNetworkRequestFailure) -> (DataRequest?) {
        
        return self.loadDataJson(Path: path,showHUD: showHud, HTTPMethod: method, parameters, parametersType, Success: success, Failure: failure)
    }
    
    //MARK: - 上传数据 相关接口
    
    ///图片 上传
    ///
    /// - Parameters:
    ///   - urlStr: url
    ///   - method: 请求方法
    ///   - params: 请求参数（根据key来拼接（后续可能回接入用户名与token））
    ///   - data: 照片数据
    ///   - name: 需要与后台协商成统一字段
    ///   - fileNameArray: 文件名称，看后台有没有要求
    ///   - headers: header 可以没有
    ///   - mimeType: mimeType
    ///   - success: 成功
    ///   - failture: 失败 -- 如果没有数据，相当于失败。
    func uploadImage(_ urlStr : String,showHud:Bool,_ method: HTTPMethod, _ params:[String:String],_ images: [KLUploadParams]?,_ compressionQuality: CGFloat? = 0.1,success : @escaping KLNetworkRequestSuccess, failture : @escaping KLNetworkRequestFailure) {
        self.uploadImageFunc(urlStr,showHUD: showHud, method, params, images!, compressionQuality, success: success, failture: failture)
    }
}

//MARK: - 下载数据 extension
private extension KLNetworkHandler {
    /// alamofire 数据请求 (数据Json)
    ///注意循环引用
    /// - Parameters:
    ///   - path: url path
    ///   - method: 请求方式
    ///   - parameters: 参数
    ///   - parametersType: 参数为 query 还是 body
    ///   - responseDateType: 网络数据类型
    ///   - success: 成功的回调
    ///   - failure: 失败的回调
    /// - Returns: Request
    @discardableResult
    func loadDataJson(Path path: String,showHUD:Bool, HTTPMethod method: RequestMethod? = .get,_ parameters: [String:Any]? = nil,_ parametersType: ParamaetersType? = nil,Success success: @escaping KLNetworkRequestSuccess, Failure failure:@escaping KLNetworkRequestFailure) -> (DataRequest?) {
        if showHUD {
            KLProgressHUD.show()
        }
        let httpMethod = HTTPMethod.init(rawValue: (method?.rawValue ?? "GET"))
        let dateRequest = RequestMenager.getLoadDataRequest(Path: path, HTTPMethod: httpMethod, parameters, parametersType)
        guard let request = dateRequest else {
            return nil
        }
        request.responseJSON(completionHandler: { [weak self] (netDate:DataResponse<Any>) in
            KLProgressHUD.dismiss()
            if self == nil{
                dPrint("🌶网络请求工具 AlamofireMenager，被销毁请检查")
            }
            let isSuccess = k_codeMenager.handleCode(netDate.response?.statusCode ?? 0, netDate.result.value, netDate.error, netDate.request?.url)
            if isSuccess && netDate.result.value != nil {
                success(netDate.value as! [String : AnyObject])
            }else{
                failure(netDate.error!)
                KLProgressHUD.showError(requestErrorMsg)
            }
        })
        return request
    }
}

//MARK: - 上传数据 extension
private extension KLNetworkHandler {
    
    ///图片 上传
    ///
    /// - Parameters:
    ///   - urlStr: url
    ///   - method: 请求方法
    ///   - params: 请求参数（根据key来拼接（后续可能回接入用户名与token））
    ///   - data: 照片数据
    ///   - name: 需要与后台协商成统一字段
    ///   - fileNameArray: 文件名称，看后台有没有要求
    ///   - headers: header 可以没有
    ///   - mimeType: mimeType
    ///   - success: 成功
    ///   - failture: 失败 -- 如果没有数据，相当于失败。
    func uploadImageFunc(_ urlStr : String,showHUD:Bool ,_ method: HTTPMethod, _ params:[String:String],_ images: [KLUploadParams],_ compressionQuality: CGFloat? = 0.1,success : @escaping KLNetworkRequestSuccess, failture : @escaping KLNetworkRequestFailure) {
        //header的上传
        let headers = ["content-type":"multipart/form-data"]
        ///url 拼接
        let requstOption = RequestMenager.getUploadRequest(urlStr, method, headers: headers)
        guard let requst = requstOption else {
            dPrint("🌶\n 数据上传 request 转化失败 " + urlStr + "🌶\n")
            return
        }
        
        AlamofireSession.default.sessionMenager.upload(multipartFormData: { multipartFormData in
            for param in images {
                multipartFormData.append(param.data, withName: param.paramKey, fileName: param.fileName, mimeType: param.mineType)
            }
        }, with: requst) { encodingResult in
            switch encodingResult {
            case .success(let request, let streamingFromDisk, let streamFileURL):
                dPrint(streamFileURL ?? "")
                dPrint(streamingFromDisk)
                request.uploadProgress(closure: { (progress) in
                    if showHUD {
                        KLProgressHUD.showProgress(CGFloat(progress.fractionCompleted))
                    }
                })
                request.responseJSON(completionHandler: { (netDate) in
                    KLProgressHUD.dismiss()
                    let isSuccess = k_codeMenager.handleCode(netDate.response?.statusCode ?? 0, netDate.result.value, netDate.error, netDate.request?.url)
                    if isSuccess && netDate.result.value != nil {
                        success(netDate.value as! [String : AnyObject])
                    }else{
                        failture(netDate.error!)
                    }
                })
            case .failure(let error):
                failture(error)
                KLProgressHUD.dismiss()
                KLProgressHUD.showError("上传文件编码错误\(error.localizedDescription)")
            }
        }
    }
}

