//
//  BlackHawkErrorsDelegate.swift
//  BlackHawk
//
//  Created by leqicheng on 15/8/28.
//  Copyright © 2015年 乐其橙科技（北京）有限公司. All rights reserved.
//

import Foundation

@objc public protocol BlackHawkErrorsDelegate: NSObjectProtocol {
    optional func BlackHawkErrors(URLEroor url: String)
    optional func BlackHawkErrors(ReflectionEroor url: String, className: String, functionName: String, message: String)
}