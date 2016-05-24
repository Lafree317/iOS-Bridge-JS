//
//  OCBrigeModel.m
//  iOS-Brige-JS
//
//  Created by 胡春源 on 16/5/24.
//  Copyright © 2016年 胡春源. All rights reserved.
//

#import "OCBridgeModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation OCBridgeModel
- (void)callWithDict:(NSDictionary *)params {
    NSLog(@"Js调用了OC的方法，参数为：%@", params);
}
/**
 *  js传递过来一个时机,弹出一个提示框
 */
- (void)alertSomething{
    // js回调的方法默认都不在主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showInfoWithStatus:@"弹一个提示框"];
    });
    
}
/**
 *  JS传值
 *
 *  @param title js传递过来的字符串
 */
- (void)passTheMessage:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showInfoWithStatus:title];
    });
}
/**
 *  接收一个JSON
 *
 *  @param dic jsonDic
 */
- (void)passJSON:(NSDictionary *)dic{
    NSLog(@"年龄:%@ 姓名:%@ 身高:%@",[dic valueForKey:@"age"],[dic valueForKey:@"name"],[dic valueForKey:@"height"]);
}
/**
 *  接收一个字符串,然后像JS回调一个方法
 *
 *  @param msg 接收字符串
 */
- (void)passMessageAndCallBack:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showInfoWithStatus:msg];
        JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
        [jsParamFunc callWithArguments:@[@{@"name": @"客户端回调的参数"}]];
    });
}

/**
 *  接收一个字符串然后判断是Pop还是Push
 *
 *  @param msg modal/dismiss
 */
- (void)popPushWithMessage:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([msg isEqualToString:@"modal"]) {
            self.modal();
        }else{
            self.dismiss();
        }
    });
}
@end
