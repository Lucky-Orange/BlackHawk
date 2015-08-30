BlackHawk
------------

BlackHawk is a Cordova compatible javascript-native reflection bridge based on fast and sexy WKWebView written in pure Swift, with incredible high performance.

##Incredible High Performance

###Let's test a shooting game called "萌战姬"

* Device: iPhone 6 4.7-inch
* ScreenShots: 
    * [Cordova](http://lvwenhan.com/content/uploadfile/201508/f84a1440930502.png)
    * [BlackHawk](http://lvwenhan.com/content/uploadfile/201508/b4921440930504.png)

###Cordova:

![pic](http://lvwenhan.com/content/uploadfile/201508/f4561440930514.png)

###BlackHawk:

![pic](http://lvwenhan.com/content/uploadfile/201508/508d1440930514.png)

> ###That's tons of progress.

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
- [ ] Bluetooth (waitting for supporting iOS8)
- [x] [Vibration](https://github.com/Lucky-Orange/BlackHawk-Plugin-Vibration)
- [x] [Device (already built in)](https://github.com/Lucky-Orange/BlackHawk-Plugin-Device)
- [ ] Device Orientation


##Requirements

* iOS 8.0 +
* Xcode 7 beta 6 (Swift 2.0)

##Architecture

[Documentation of Architecture](https://github.com/Lucky-Orange/BlackHawk/wiki/Architecture)

##How to Use

###include as sub project

Drag BlackHawk/BlackHawk.xcodeproj into your project as d sub project.

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

##Contribution

If you have any suggestions please open an issue, and you are very welcome to fork and submit pull requests.

####Plugins for BlackHawk will be best news!

##LICENSE
BlackHawk is open-sourced software licensed under the MIT license.

Copyright (c) 2015 Leqicheng Inc. 乐其橙科技（北京）有限公司
