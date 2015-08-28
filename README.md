BlackHawk
------------

BlackHawk is a Codova-like javascript-native bridge based on fast and sexy WKWebView written in pure Swift, with incredible high performance: RAM/CPU cost from 140MB / 100% to 9MB / 5%.

##Fetures

###Basic

BlackHawk is a Cordova-like software that provides a javascript to native reflection bridge, written in pure Swift, aimed to provide a modern, hight-performance replacement of Crodova on iOS platform. BlackHawk uses WKWebView in Apple's new WebKit Framework and pure Swift Language.

###High Performance
With BlackHawk, you can reduce the cost of RAM and CPU significantly, especially for complicated HTML5 pages. A chinese shooting game called "萌战姬" was tested on iPod Touch 6 with BlackHawk and Cordova that BlackHawk can reduce the RAM/CPU cost from 140MB / 100% on UIWebView to 9MB / 5%. That's tons of progress.

(BTW, the full CPU occupancy rate on MAC/iOS is 100% per core.)

##Requirements

* iOS 8.0 +
* Xcode 7 beta 6 (Swift 2.0)

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

##LICENSE
BlackHawk is open-sourced software licensed under the MIT license.

Copyright (c) 2015 Leqicheng Inc. 乐其橙科技（北京）有限公司
