//
//  SwiftModel.swift
//  iOS-Brige-JS
//
//  Created by 胡春源 on 16/5/24.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import JavaScriptCore
typealias modelDisMissBlock = ()-> Void
class SwiftBridgeModel: NSObject, JavaScriptSwiftDelegate {
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    var modal:modelDisMissBlock!
    var dismiss:modelDisMissBlock!
    /**
     *  接收一个弹提示框的时机
     */
    func alertSomething() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            SVProgressHUD.showInfoWithStatus("弹一个提示框")
        }

    }
    
    /**
     *  接收一个字符串
     *
     *  @param title js传递过来的字符串
     */
    func passTheMessage(title: String) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            SVProgressHUD.showInfoWithStatus(title)
        }
    }
    
    /**
     *  接收一个JSON
     *
     *  @param dic jsonDic
     */
    func passJSON(dict: [String: AnyObject]) {
        print(dict)
    }
    
    /**
     *  接收一个字符串,然后像JS回调一个方法
     *
     *  @param msg 接收字符串
     */
    func passMessageAndCallBack(msg:String) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let context = JSContext()
            context.evaluateScript("var num = 10")
            // 向JS注入一段代码并执行,square是JS系统方法
            context.evaluateScript("function square(value) { return value * 2}")
            // 直接调用
            let squareValue = context.evaluateScript("square(num)")
            // 打印结果
            print(squareValue)
            
            // 获取js已声明方法
            let js = self.jsContext!.evaluateScript("jsParamFunc")
            // 传递参数
            js.callWithArguments([["name":"客户端回调的参数"]])
        }
    }
    
    /**
     *  接收一个字符串然后判断是Pop还是Push
     *
     *  @param msg modal/dismiss
     */
    func popPushWithMessage(msg:String){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if msg == "modal" {
                self.modal()
            }else{
                self.dismiss()
            }
        }
    }
    
}