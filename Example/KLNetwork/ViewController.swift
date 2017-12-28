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
        
        KLNetWork.get("https://httpbin.org/get", success: { (response) in
            
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

