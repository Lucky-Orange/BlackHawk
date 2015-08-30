//
//  Device.swift
//  BlackHawk
//
//  Created by leqicheng on 15/8/30.
//  Copyright © 2015年 乐其橙科技（北京）有限公司. All rights reserved.
//

import WebKit

class Device {
    static func injectValuesInToRuntime(wk: WKWebView) {
        let cordova = "BlackHawk 0.1"
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        var identifier = String()
        for i in mirror.children
        {
            let value = i.value as? Int8
            if (value != nil && value != 0)
            {
                identifier.append(UnicodeScalar(UInt8(value!)))
            }
        }
        let model = identifier
        let platform = "iOS"
        let uuid = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let version = UIDevice.currentDevice().systemVersion
        wk.evaluateJavaScript("device={cordova: '\(cordova)', model: '\(model)', platform: '\(platform)', uuid: '\(uuid)', version: '\(version)'}", completionHandler: nil)
    }
}