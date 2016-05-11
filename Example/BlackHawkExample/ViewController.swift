//
//  ViewController.swift
//  BlackHawkExample
//
//  Created by leqicheng on 15/8/28.
//  Copyright © 2015年 乐其橙科技（北京）有限公司. All rights reserved.
//

import UIKit
import BlackHawk

class ViewController: BlackHawkViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.runPluginJS(["Accelerometer", "Console", "Vibration", "Scanner"])
        
        self.wk.loadFileURL(NSBundle.mainBundle().URLForResource("index", withExtension: "html", subdirectory: "www")!, allowingReadAccessToURL: NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("www", isDirectory: true))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

