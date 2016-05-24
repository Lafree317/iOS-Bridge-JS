//
//  ViewController.m
//  iOS-Brige-JS
//
//  Created by 胡春源 on 16/5/24.
//  Copyright © 2016年 胡春源. All rights reserved.
//

#import "ViewController.h"
#import "OCWebViewController.h"
#import "iOSBridgeJS-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)OCClick:(UIButton *)sender {
    [self showViewController:[OCWebViewController new] sender:nil];
}
- (IBAction)SwiftClick:(id)sender {
    [self showViewController:[SwiftWebViewController new] sender:nil];
}

@end
