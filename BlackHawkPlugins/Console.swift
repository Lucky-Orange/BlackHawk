//
//  Console.swift
//  BlackHawk
//
//  Created by leqicheng on 15/8/28.
//  Copyright © 2015年 乐其橙科技（北京）有限公司. All rights reserved.
//

import BlackHawk

class Console: BlackHawkPlugin {
    func log() {
        if let string = self.data {
            NSLog("BlackHawk >>> " + string)
        }
    }
}