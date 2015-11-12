//
//  BlackHawkPlugin.swift
//  BlackHawk
//
//  Created by leqicheng on 15/8/28.
//  Copyright © 2015年 乐其橙科技（北京）有限公司. All rights reserved.
//

import WebKit

public class BlackHawkPlugin: NSObject {
    public var wk: WKWebView!
    public var taskId: Int!
    public var data: String?
    public required override init() {
    }
    public func callback(values: NSDictionary) -> Bool {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(values, options: NSJSONWritingOptions())
            if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as? String {
                let js = "fireTask(\(self.taskId), '\(jsonString)');"
                self.wk.evaluateJavaScript(js, completionHandler: nil)
                return true
            }
        } catch let error as NSError{
            NSLog(error.debugDescription)
            return false
        }
        return false
    }
    public func errorCallback(errorMessage: String) {
        let js = "onError(\(self.taskId), '\(errorMessage)');"
        self.wk.evaluateJavaScript(js, completionHandler: nil)
    }
}