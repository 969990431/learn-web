//
//  WebViewController.m
//  xingTianwa_Student_Phone
//
//  Created by 天娃教育 on 09/08/2022.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

@interface WebViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
@property (retain, nonatomic) WKWebView *webView;
@property (nonatomic, strong)UIImage *shareImage;
@property (nonatomic, copy)NSString *picUrl;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Public_Back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction)];
    
    _webView = [[WKWebView alloc] init];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [_webView loadRequest:request];
    
}



- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - JS 交互处理

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"jsObject"];
    //    发送登录信息给js
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"JSSendLoginStatusToNative"];
    //    参团弹窗点击我知道了
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"JSJoinGroupSucceedBack"];
    //    查看我的团点击
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"JSCheckMyGroupList"];
    //    拼团中分享点击
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"JSShareMyGrouping"];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"jsObject"];

    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSSendLoginStatusToNative"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSJoinGroupSucceedBack"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSCheckMyGroupList"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"JSShareMyGrouping"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = (NSDictionary *)message.body;
    NSString *name = message.name;
    NSLog(@"body  = %@", body);
    if([name isEqualToString:@"jsObject"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}



- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSString *jsString = [NSString stringWithFormat:@"NativeSendLoginInfoToJS('{\"token\":\"123123123\", \"uid\":\"1111\",\"stuId\":\"222\",\"activityId\":\"333\"}')"];
    NSString *jsString = @"NativeSendLoginInfoToJS('{\"name\":\"namename\"}')";
    [webView evaluateJavaScript:jsString completionHandler:^(id response, NSError * _Nullable error) {
        NSLog(@"error: %@", error.description);
        NSLog(@"response: %@", response);
    }];
}

@end
