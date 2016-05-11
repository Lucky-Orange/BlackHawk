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
    
    public var wk: WKWebView!
    public var url: String! {
        didSet{
            if let urlString = self.url {
                if let url = NSURL(string: urlString) {
                    let request = NSURLRequest(URL: url)
                    self.wk.loadRequest(request)
                    NSLog("Load ended: \(self.url)")
                } else {
                    NSLog("URL error!")
                    self.delegate?.BlackHawkErrors?(URLEroor: urlString)
                }
            } else {
                NSLog("ERROR!! Please set self.url before viewDidAppear.")
            }
        }
    }
    public var delegate: BlackHawkErrorsDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let conf = WKWebViewConfiguration()
        conf.userContentController.addScriptMessageHandler(self, name: "BlackHawk")
        
        self.wk = WKWebView(frame: CGRectMake(0, 0, 10, 10), configuration: conf)
        self.wk.UIDelegate = self
        self.wk.navigationDelegate = self
        self.wk.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.wk)
        self.view.sendSubviewToBack(self.wk)
        
        self.runPluginJS(["Base"])
        Device.injectValuesInToRuntime(self.wk)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.wk, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.wk, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.wk, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.wk, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            if let a = message.body as? NSDictionary, className = a["className"]?.description, functionName = a["functionName"]?.description {
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

private typealias wkNavigationDelegate = BlackHawkViewController
extension wkNavigationDelegate {
    
    public func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        NSLog(error.debugDescription)
    }
    public func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        NSLog(error.debugDescription)
    }
}

private typealias wkRunPluginDelegate = BlackHawkViewController
extension wkRunPluginDelegate {
    public func runPluginJS(names: Array<String>) {
        for name in names {
            if let path = NSBundle.mainBundle().pathForResource(name, ofType: "js", inDirectory: "www/plugins") {
                do {
                    let js = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                    self.wk.evaluateJavaScript(js as String, completionHandler: nil)
                } catch let error as NSError {
                    NSLog(error.debugDescription)
                }
            }
        }
    }
}