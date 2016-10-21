//
//  XSMEmotionTabBar.h
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XSMEmotionTabBarButtonType) {
    XSMEmotionTabBarButtonTypeRecent,
    XSMEmotionTabBarButtonTypeDefault,
    XSMEmotionTabBarButtonTypeEmoji,
    XSMEmotionTabBarButtonTypeLang
};
@class XSMEmotionTabBar;

@protocol XSMEmotionTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickButton:(XSMEmotionTabBar *)tabBar button:(XSMEmotionTabBarButtonType)type;

@end


@interface XSMEmotionTabBar : UIView

@property (nonatomic, weak) id<XSMEmotionTabBarDelegate> delegate;
@property (nonatomic, weak) UIButton *selectedBtn;

@end
