//
//  XSMDropdownMenu.h
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSMGlobal.h"
@class XSMDropdownMenu;

@protocol XSMDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(XSMDropdownMenu *)dropdownMenu;
- (void)dropdownMenuDidShow:(XSMDropdownMenu *)dropdownMenu;
@end

@interface XSMDropdownMenu : UIView

@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIViewController *contentVC;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, weak) id<XSMDropdownMenuDelegate> delegate;

+ (instancetype)dropdownMenu;
- (void)showFrom:(UIView *)from;
//点击view时，用来移除View
- (void)dismiss;

@end
