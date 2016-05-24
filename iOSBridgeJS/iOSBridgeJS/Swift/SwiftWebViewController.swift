//
//  SwiftWebViewController.swift
//  iOS-Brige-JS
//
//  Created by 胡春源 on 16/5/24.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit
import JavaScriptCore

// All methods that should apply in Javascript, should be in the following protocol.
// 注意，这里必须使用@objc，因为JavaScriptCore库是ObjectiveC版本的。如果不加@objc，则调用无效果。
@objc protocol JavaScriptSwiftDelegate: JSExport {
    
    /**
     *  接收一个弹提示框的时机
     */
    func alertSomething()
    
    /**
     *  接收一个字符串
     *
     *  @param title js传递过来的字符串
     */
    func passTheMessage(title: String)
    
    /**
     *  接收一个JSON
     *
     *  @param dic jsonDic
     */
    func passJSON(dict: [String: AnyObject])
    
    /**
     *  接收一个字符串,然后像JS回调一个方法
     *
     *  @param msg 接收字符串
     */
    func passMessageAndCallBack(msg:String)
    
    /**
     *  接收一个字符串然后判断是Pop还是Push
     *
     *  @param msg modal/dismiss
     */
    func popPushWithMessage(msg:String)
}

class SwiftWebViewController: UIViewController,UIWebViewDelegate {
    var webView: UIWebView!
    var jsContext: JSContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView = UIWebView(frame: self.view.bounds);
        self.view.addSubview(self.webView)
        self.webView.delegate = self
        self.webView.scalesPageToFit = true
        let url = NSBundle.mainBundle().URLForResource("test", withExtension: "html")
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)
        
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        let context = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext
        let model = SwiftBridgeModel()
        model.controller = self
        model.jsContext = context
        model.dismiss = {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        model.modal = {
            self.showViewController(SwiftWebViewController(), sender: nil)
        }
        self.jsContext = context
        
        // 这一步是将OCModel这个模型注入到JS中，在JS就可以通过OCModel调用我们公暴露的方法了。
        self.jsContext?.setObject(model, forKeyedSubscript: "OCModel")
        let url = NSBundle.mainBundle().URLForResource("test", withExtension: "html")
        self.jsContext?.evaluateScript(try? String(contentsOfURL: url!, encoding: NSUTF8StringEncoding));
        
        self.jsContext?.exceptionHandler = {
            (context, exception) in
            print("exception @", exception)
        }
    }

}
