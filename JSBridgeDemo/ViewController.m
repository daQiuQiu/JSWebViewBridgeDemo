//
//  ViewController.m
//  JSBridgeDemo
//
//  Created by 易仁 on 16/3/28.
//  Copyright © 2016年 易仁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myWeb.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self registerHandler];
    
}

-(void)registerHandler {
//    if (bridge) { return; }
    
//    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.myWeb webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"初始化");
    }];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
        
    }];//发送
    
    [_bridge callHandler:@"testJavascriptHandler" data:@"color"];
    
    
    
    
    [self loadExamplePage:_myWeb];

}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}


- (void)callHandler {
    id data =  @"tanchuang" ;
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}


- (IBAction)didCallJS:(UIButton *)sender {
    [self callHandler];
}

- (IBAction)reloadWeb:(UIButton *)sender {
    [self.myWeb reload];
}
@end
