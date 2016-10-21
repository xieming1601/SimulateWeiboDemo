//
//  XSMTabBar.h
//  Weibo
//
//  Created by xsm on 2016/10/12.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSMGlobal.h"

@protocol XSMTabBarDelegate<NSObject>

@optional
-(void)tabBarDidClickPlusButton:(UITabBar *)tabBar;

@end

@interface XSMTabBar : UITabBar

@property (nonatomic, strong) UIButton *plusButton;

//区别于父类的delegate
@property (nonatomic, weak) id<XSMTabBarDelegate> delegate1;

@end
