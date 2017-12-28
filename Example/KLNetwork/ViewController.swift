//
//  ViewController.swift
//  KLNetwork
//
//  Created by 雷珂阳 on 2017/12/25.
//  Copyright © 2017年 雷珂阳. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let params  = ["assistId":167] as [String : Any]
//
//        KLNetWork.get("http://39.104.56.121:8083/api/user/info", parameters: nil, success: { (response) in
//            print(response)
//        }) { (error) in
//
//        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        //开始下载
//        Alamofire.download("http://120.25.226.186:32812/resources/videos/minion_09.mp4", to: destination).downloadProgress(closure: { (progress) in
//            print(progress.completedUnitCount,progress.totalUnitCount)
//        }).response { response in
//                print("response",response)
//                if let imagePath = response.destinationURL?.path {
//                    let image = UIImage(contentsOfFile: imagePath)
//        print("path",imagePath)
//
//            }
//        }
        
//        KLNetWork.downloadWithShowHUD("http://120.25.226.186:32812/resources/videos/minion_09.mp4", toPath: nil, parameters: nil, progress: { (ready, total) in
//
//        }) { (result, status) in
//            print(result!,status)
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

