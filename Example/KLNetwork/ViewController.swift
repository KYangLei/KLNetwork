//
//  ViewController.swift
//  KLNetwork
//
//  Created by 雷珂阳 on 2017/12/25.
//  Copyright © 2017年 雷珂阳. All rights reserved.
//

import UIKit
import KLProgressHUD

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        KLNetworkHandler.sharedManager.loadData(Path: "member/getMember", showHud: true, HTTPMethod: .get, nil, .body, Success: { (response:[String:AnyObject]) in
        }) { (error) in

        }
        
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
