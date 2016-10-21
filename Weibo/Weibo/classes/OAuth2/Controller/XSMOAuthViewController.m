//
//  XSMOAuthViewController.m
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMOAuthViewController.h"
#import "AFNetworking.h"
#import "XSMAccount.h"
#import "XSMMainViewController.h"
#import "XSMNewFeatureViewController.h"

@interface XSMOAuthViewController ()

@end

@implementation XSMOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] init];
//    webView.frame = self.view.bounds;
    webView.delegate = self;
    webView.backgroundColor = [UIColor redColor];
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:webView];
    
    //使用autoLayout布局
    //创建webView第一个约束，相对self.view的左边缘间距0
    NSLayoutConstraint * leftLc = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0];
    //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
    [self.view addConstraint:leftLc];
    
    //创建redView第二个约束，相对self。view的底边缘间距0
    NSLayoutConstraint *bottomLc = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0];//由于是redview相对
    [self.view addConstraint:bottomLc];
    
    //创建webView第一个约束，相对self.view的右边缘间距0
    NSLayoutConstraint * rightLc = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0];
    [self.view addConstraint:rightLc];
    
    //创建redView第二个约束，相对self。view的上边缘间距20
    NSLayoutConstraint *topLc = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:20.0];//由于是redview相对
    //添加约束
    [self.view addConstraint:topLc];
    
    //这里在加载时候由于是外部的URL，必须在info.plist中设置App Transport Security Settings的属性值才可以显示
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=175069701&redirect_uri=http://www.baidu.com"];
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = (int)range.location + (int)range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
        //返回NO， 不跳转到redirect_uri
        return NO;
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //serializer手动添加了一个支持的格式
    //    mgr.responseSerializer = [AFJSONRequestSerializer serializer];
    
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"175069701";
    params[@"client_secret"] = @"a59e7e86d19e80ce90ee17bb99888919";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    
    //新浪官方api ： http://open.weibo.com/wiki/Oauth2/access_token
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"成功 + %@", responseObject);
        //拿到Documents路径
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        /**
         NSString *account = [documents stringByAppendingPathComponent:@"account.plist"];
         //直接将返回的dictionary保存到documents路径
         [responseObject writeToFile:account atomically:YES];
         */
        NSString *accountPath = [documents stringByAppendingPathComponent:@"account.archive"];
        //转model
        XSMAccount *account = [XSMAccount accountWithDict:responseObject];
        //使用归档，需要model重写两个方法，遵守NSCoding
        [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
        
        //成功授权，登陆，跳转到weibo页面
        //根据userDefaults存储的version设置rootVC
        NSString *versionKey = @"CFBundleVersion";
        NSString *formerVersion = [[NSUserDefaults standardUserDefaults] valueForKey:versionKey];
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] valueForKey:versionKey];
        //如果formerVersion储存的和当前info.plist里的不同，就显示new feature;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        if ([formerVersion isEqualToString:currentVersion]) {
            XSMMainViewController *mainVC = [[XSMMainViewController alloc] init];
            [window setRootViewController:mainVC];
        } else {
            XSMNewFeatureViewController *newFeatureVC = [[XSMNewFeatureViewController alloc] init];
            [window setRootViewController:newFeatureVC];
        }
        
        //将currentVersion 保存到userDefaults当中
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败 + %@", error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
