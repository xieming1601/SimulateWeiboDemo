//
//  XSMMainViewController.h
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSMTabBar.h"

@interface XSMMainViewController : UITabBarController<XSMTabBarDelegate>

@property (nonatomic, weak) UIViewController *vc;

@end
