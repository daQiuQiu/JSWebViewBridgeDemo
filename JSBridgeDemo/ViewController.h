//
//  ViewController.h
//  JSBridgeDemo
//
//  Created by 易仁 on 16/3/28.
//  Copyright © 2016年 易仁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"
@interface ViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWeb;
@property (strong, nonatomic) WebViewJavascriptBridge *bridge;
- (IBAction)didCallJS:(UIButton *)sender;
- (IBAction)reloadWeb:(UIButton *)sender;


@end

