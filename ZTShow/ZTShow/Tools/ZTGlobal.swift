//
//  ZTGlobal.swift
//  ZTShow
//
//  Created by zhangtian on 2021/6/5.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let STATUS_BAR_HEIGHT: CGFloat = Full_Screen ? 44:20
let TOP_HEIGHT: CGFloat = Full_Screen ? 88:64
let BOTTOM_SAFE_HEIGHT: CGFloat = Full_Screen ? 34:0
let BOTTOM_HEIGHT: CGFloat = Full_Screen ? 83:49
let iPhoneX:Bool = __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));
let iPhoneXR:Bool = __CGSizeEqualToSize(CGSize(width: 828, height: 1792), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));
let iPhoneXs:Bool = __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));
let iPhoneXSMAX:Bool = __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));
let iPhoneX_All:Bool = iPhoneX||iPhoneXR||iPhoneXs||iPhoneXSMAX ;
let iPhone12Mini:Bool = __CGSizeEqualToSize(CGSize(width: 1080, height: 2340), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));
let iPhone12:Bool = __CGSizeEqualToSize(CGSize(width: 1170, height: 2532), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));
let iPhone12ProMax:Bool = __CGSizeEqualToSize(CGSize(width: 1284, height: 2778), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));
let Full_Screen=(iPhoneX_All||iPhone12Mini||iPhone12||iPhone12ProMax)
