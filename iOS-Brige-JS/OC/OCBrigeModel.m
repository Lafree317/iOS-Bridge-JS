//
//  OCBrigeModel.m
//  iOS-Brige-JS
//
//  Created by 胡春源 on 16/5/24.
//  Copyright © 2016年 胡春源. All rights reserved.
//

#import "OCBrigeModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation OCBrigeModel
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
// Js调用了callSystemCamera
- (void)callSystemCamera {
    NSLog(@"JS调用了OC的方法，调起系统相册");
    
    // JS调用后OC后，又通过OC调用JS，但是这个是没有传参数的
    JSValue *jsFunc = self.jsContext[@"jsFunc"];
    [jsFunc callWithArguments:nil];
}

- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params {
    NSLog(@"jsCallObjcAndObjcCallJsWithDict was called, params is %@", params);
    
    // 调用JS的方法
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"age": @10, @"name": @"lili", @"height": @158}]];
}

- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [a show];
    });
}

@end
