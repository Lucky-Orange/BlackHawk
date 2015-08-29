BlackHawk
------------

BlackHawk is a Cordova like javascript-native reflection bridge based on fast and sexy WKWebView written in pure Swift, with incredible high performance: RAM/CPU cost reduced from 140MB / 100% to 9MB / 5% when running a complicated HTML5 game.

##Features

###Basic Feature

BlackHawk is a Cordova like software that provides a javascript to native reflection bridge, written in pure Swift, aimed to provide a modern, hight-performance replacement of Cordova  on iOS platform. BlackHawk uses WKWebView in Apple's new WebKit Framework with pure Swift Language.

###High Performance
With BlackHawk, you can reduce the cost of RAM and CPU significantly, especially for complicated HTML5 pages. A chinese shooting game called "萌战姬" was tested on iPod Touch 6 with BlackHawk and Cordova that BlackHawk can reduce the RAM/CPU cost from 140MB / 100% on UIWebView to 9MB / 5%. That's tons of progress.

(BTW, the full CPU occupancy rate on MAC/iOS is 100% per core.)

##Architecture

###Basic Architecture

BlackHawk provide a framework working as a sub Xcode project. Everything is inside the BlackHawkViewController Class.

Inside BlackHawk there is a WKWebView with the same frame of BlackHawkViewController's view, and with some functions from WKScriptMessageHandler, WKUIDelegate and WKNavigationDelegate delegates. Because of Apple's strict policy on web view kernel, all the useful functions and the high performance are from WKWebView directly.

WITHOUT ANY PRIVATE APIs.

###How Dose Javascript Send Messages to Native Layer

We use `userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage)` in WKScriptMessageHandler delegate to receive messages sent by javascript. Sendding messages in javascript is pretty easy in WKWebView:

```js
// js code
window.webkit.messageHandlers.BlackHawk.postMessage('Hello BlackHawk!');
```

We had registed it before:

```swift
// swift code
let conf = WKWebViewConfiguration()
conf.userContentController.addScriptMessageHandler(self, name: "BlackHawk")
```

###How Dose BlackHawk Fire Up Some Code

As we all know Swift is a compiled language the same as Objective-C. But thanks to the [Objective-C Runtime](https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/ObjCRuntimeRef/) we has lots of powerful reflection functions.

We use `window.webkit.messageHandlers.BlackHawk.postMessage` send a JavaScript Object with all information we need to native layer:

```js
window.webkit.messageHandlers.BlackHawk.postMessage({className: 'Console', functionName: 'log', taskId: Queue.length - 1, data: string});
```

Then we can get a NSDictionary on native layer, so we get the class name and the function name.

####Get the Object

```swift
if let cls = NSClassFromString(NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName")!.description + "." + className) as? BlackHawkPlugin.Type{
    let obj = cls.init()
}
```

Thanks to the completely Object Oriented Swift, we can reflect a object much more safe and flexible:

> 1. Full class name is CFBundleName + ClassName in Swift
> 2. The native plugin class must inherit from BlackHawkPlugin class
> 3. You can call any function in any plugin class freely

####Fire the Function

BlackHawkPlugin inherit form NSObject, so we use `performSelector()` to fire the function you need.

###How Dose Native Layer Send messages to Javascript Runtime

The WKWebView object `wk` has been set to every plugin object's wk property, so we can fire some javascript code easily:

```swift
self.wk.evaluateJavaScript("alert(1);", completionHandler: nil)
```

##Cordova Compatible

The ultimate goal of BlackHawk is being a complete replacement of Cordova on iOS platform, so that BlackHawk is fully compatible with Cordova's javascript API.

###Check-list of BlackHawk plugins:

- [x] Console
- [x] Accelerometer
- [ ] Bluetooth (waitting for it's support of iOS8)
- [ ] Vibration
- [ ] Device
- [ ] Device Orientation


####If you have any suggestions please open an issue. Plugins for BlackHawk will be the best things!

##Requirements

* iOS 8.0 +
* Xcode 7 beta 6 (Swift 2.0)

##How to Use

to be filled.

##LICENSE
BlackHawk is open-sourced software licensed under the MIT license.

Copyright (c) 2015 Leqicheng Inc. 乐其橙科技（北京）有限公司
