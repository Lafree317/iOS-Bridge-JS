//
//  OCWebViewController.h
//  iOS-Brige-JS
//
//  Created by 胡春源 on 16/5/24.
//  Copyright © 2016年 胡春源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JavaScriptObjectiveCDelegate <JSExport>
/**
 *  接收一个弹提示框的时机
 */
- (void)alertSomething;
/**
 *  接收一个字符串
 *
 *  @param title js传递过来的字符串
 */
- (void)passTheMessage:(NSString *)title;
/**
 *  接收一个JSON
 *
 *  @param dic jsonDic
 */
- (void)passJSON:(NSDictionary *)dic;
/**
 *  接收一个字符串,然后像JS回调一个方法
 *
 *  @param msg 接收字符串
 */
- (void)passMessageAndCallBack:(NSString *)msg;
/**
 *  接收一个字符串然后判断是Pop还是Push
 *
 *  @param msg pop/push
 */
- (void)popPushWithMessage:(NSString *)msg;

@end

@interface OCWebViewController : UIViewController

@end
