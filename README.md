BlackHawk
------------

BlackHawk is a Cordova compatible javascript-native reflection bridge based on fast and sexy WKWebView written in pure Swift, with incredible high performance.

*Notice: NOT ready for production*

##Incredible High Performance

###Let's test a shooting game called "萌战姬"

* Device: iPhone 6 4.7-inch
* ScreenShots: 
    * [Cordova](http://lvwenhan.com/content/uploadfile/201508/f84a1440930502.png)
    * [BlackHawk](http://lvwenhan.com/content/uploadfile/201508/b4921440930504.png)

####Cordova:

![pic](http://lvwenhan.com/content/uploadfile/201508/f4561440930514.png)

####BlackHawk:

![pic](http://lvwenhan.com/content/uploadfile/201508/508d1440930514.png)

> ###That's tons of progress.

###Let's test "萌战姬" on iPhone 4S

* Device: iPhone 4S

####Cordova:

* fps: 15-18
* fps when explosion: 1-5
* [ScreenShot](http://lvwenhan.com/content/uploadfile/201508/d4c21440998158.png)

####BlackHawk:

* fps: 26-30
* fps when explosion: 15-20
* [ScreenShot](http://lvwenhan.com/content/uploadfile/201508/b25f1440998119.png)

####BlackHawk makes "萌战姬" can be played on iPhone 4S now.

##Features

####Basic Features

BlackHawk is a Cordova like software that provides a javascript to native reflection bridge, written in pure Swift, aimed to provide a modern, hight-performance replacement of Cordova  on iOS platform. BlackHawk uses WKWebView in Apple's new WebKit Framework with pure Swift Language.

####High Performance
BlackHawk can reduce the cost of RAM and CPU significantly, especially for complicated HTML5 pages.

##Cordova Compatible

The ultimate goal of BlackHawk is being a complete replacement of Cordova on iOS platform, so that BlackHawk is fully compatible with Cordova's javascript API.

####Check-list of BlackHawk plugins:

- [x] [Console](https://github.com/Lucky-Orange/BlackHawk-Plugin-Console)
- [x] [Accelerometer](https://github.com/Lucky-Orange/BlackHawk-Plugin-Accelerometer)
- [ ] Bluetooth (waiting for supporting iOS8)
- [x] [Vibration](https://github.com/Lucky-Orange/BlackHawk-Plugin-Vibration)
- [x] [Device (already built in)](https://github.com/Lucky-Orange/BlackHawk-Plugin-Device)
- [ ] Device Orientation


##Requirements

* iOS 8+
* Xcode 7+ (Swift 2+)

##Architecture

[Documentation of Architecture](https://github.com/Lucky-Orange/BlackHawk/wiki/Architecture)

##How to Use

###include as sub project

Drag BlackHawk/BlackHawk.xcodeproj into your project as a sub project.

###copy files

Copy `www` directory to your project, and add it to `Build Phases` > `Copy Bundle Resources`.

![pic](http://lvwenhan.com/content/uploadfile/201508/89811440934073.png)

###write some code

In anywhere you want to show a BlackHawk View Controller:

```swift
import UIKit
import BlackHawk

class ViewController: BlackHawkViewController {

... ...
```

###run on devices

If you want to run your project on a device, just do one thing:

![pic](http://lvwenhan.com/content/uploadfile/201508/de471440934490.png)

###That's it!

##What can BlackHawk be?

BlackHawk is cordova compatible, actually it's a javascript-native reflection bridge, cordova compatible layer is just one of many layers on it.

Obviously you can build your own layer based on your own protocol. Maybe next killer Hybrid Development Framework will be made by you!

##Make a plugin for BlackHawk

If you want to build a plugin named `Nothing`, you need to do 3 steps to make your plugin run:

1. new a javascript file named `Nothing.js` in `www/plugins` directory
2. add `Nothing` to the params of self.runPluginJS(["Base"]) in BlackHawkViewController class.
3. do everything you want in `Nothing.js`, new a Swift file or not depends on you. If you want, just see:
    
    ```swift
    // js code
    Queue.push(Task.init(Queue.length, onSuccess, onError));
    window.webkit.messageHandlers.BlackHawk.postMessage({
        className: 'NothingClassName',
        functionName: 'functionName',
        taskId: Queue.length - 1,
        data: 'nothing'
    });
    ```

##Contribution

If you have any suggestions please open an issue, and you are very welcome to fork and submit pull requests.

####Plugins for BlackHawk will be best news!

##LICENSE
BlackHawk is open-sourced software licensed under the MIT license.

Copyright (c) 2015 Leqicheng Inc. 乐其橙科技（北京）有限公司
