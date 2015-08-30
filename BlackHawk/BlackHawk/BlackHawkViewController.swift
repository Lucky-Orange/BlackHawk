//
//  BlackHawkViewController.swift
//  BlackHawk
//
//  Created by leqicheng on 15/8/28.
//  Copyright © 2015年 乐其橙科技（北京）有限公司. All rights reserved.
//

import UIKit
import WebKit

public class BlackHawkViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    
    public var wk = WKWebView()
    public var url: String!
    public var delegate: BlackHawkErrorsDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let urlString = self.url {
            if let url = NSURL(string: urlString) {
                let request = NSURLRequest(URL: url)
                
                let conf = WKWebViewConfiguration()
                conf.userContentController.addScriptMessageHandler(self, name: "BlackHawk")
                
                wk = WKWebView(frame: self.view.frame, configuration: conf)
                wk.UIDelegate = self
                wk.navigationDelegate = self
                wk.translatesAutoresizingMaskIntoConstraints = false
                wk.loadRequest(request)
                
                self.view.addSubview(wk)
                self.view.sendSubviewToBack(wk)

                self.runPluginJS(["Base", "Accelerometer", "Console", "Vibration"])
                
                self.view.addConstraint(NSLayoutConstraint(item: wk, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: wk, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: wk, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0))
                self.view.addConstraint(NSLayoutConstraint(item: wk, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
            } else {
                NSLog("URL error!")
                self.delegate?.BlackHawkErrors?(URLEroor: urlString)
            }
        } else {
            NSLog("ERROR!! Please set self.url before viewDidAppear.")
        }
    }
    
    func runPluginJS(names: Array<String>) {
        for name in names {
            if let path = NSBundle.mainBundle().pathForResource(name, ofType: "js", inDirectory: "www/plugins") {
                do {
                    let js = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                    wk.evaluateJavaScript(js as String, completionHandler: nil)
                } catch let error as NSError {
                    NSLog(error.debugDescription)
                }
            }
        }
    }

}

private typealias wkUIDelegate = BlackHawkViewController
extension wkUIDelegate {
    
    public func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        self.presentViewController(ac, animated: true, completion: nil)
    }
}

private typealias wkScriptMessageHandler = BlackHawkViewController
extension wkScriptMessageHandler {
    
    public func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "BlackHawk") {
            if let a = message.body as? NSDictionary {
                if let className = a["className"]?.description {
                    if let functionName = a["functionName"]?.description {
                        if let cls = NSClassFromString(NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName")!.description + "." + className) as? BlackHawkPlugin.Type{
                            let obj = cls.init()
                            let functionSelector = Selector(functionName)
                            if obj.respondsToSelector(functionSelector) {
                                obj.wk = self.wk
                                obj.taskId = a["taskId"]?.integerValue
                                obj.data = a["data"]?.description
                                obj.performSelector(functionSelector)
                            } else {
                                let errorMessage = "Reflection Failure! Not found \(functionName) in \(className) Class"
                                NSLog(errorMessage)
                                self.delegate?.BlackHawkErrors?(ReflectionEroor: self.url, className: functionName, functionName: functionName, message: errorMessage)
                            }
                        } else {
                            let errorMessage = "Reflection Failure! Class \(className) Not found"
                            NSLog(errorMessage)
                            self.delegate?.BlackHawkErrors?(ReflectionEroor: self.url, className: className, functionName: functionName, message: errorMessage)
                        }
                    } else {
                        let errorMessage = "Reflection Failure! Data error: \(message.body)"
                        NSLog(errorMessage)
                        self.delegate?.BlackHawkErrors?(ReflectionEroor: self.url, className: "", functionName: "", message: errorMessage)
                    }
                }
            }
        }
    }
}

private typealias wkNavigationDelegate = BlackHawkViewController
extension wkNavigationDelegate {
    
    public func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        NSLog(error.debugDescription)
    }
    public func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        NSLog(error.debugDescription)
    }
}
