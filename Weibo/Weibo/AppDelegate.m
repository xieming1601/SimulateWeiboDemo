//
//  AppDelegate.m
//  Weibo
//
//  Created by xsm on 2016/10/10.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "AppDelegate.h"
#import "XSMNewFeatureViewController.h"
#import "XSMAccount.h"
#import "XSMMainViewController.h"
#import "XSMOAuthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //根据userDefaults存储的version设置rootVC
    NSString *versionKey = @"CFBundleVersion";
    NSString *formerVersion = [[NSUserDefaults standardUserDefaults] valueForKey:versionKey];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] valueForKey:versionKey];
    
    //获取已保存的帐号
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *accountPath = [documents stringByAppendingPathComponent:@"account.archive"];
    
//    NSLog(@"%@",accountPath);
    
    XSMAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
 
    if (account) {
        //如果formerVersion储存的和当前info.plist里的不同，就显示new feature;
        if ([formerVersion isEqualToString:currentVersion]) {
            XSMMainViewController *mainVC = [[XSMMainViewController alloc] init];
            [self.window setRootViewController:mainVC];

        } else {
            XSMNewFeatureViewController *newFeatureVC = [[XSMNewFeatureViewController alloc] init];
            [self.window setRootViewController:newFeatureVC];
        }
        
        //将currentVersion 保存到userDefaults当中
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        //OAuth页面
        XSMOAuthViewController *authVC = [[XSMOAuthViewController alloc] init];
        [self.window setRootViewController:authVC];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
