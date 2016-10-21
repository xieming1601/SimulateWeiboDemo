//
//  XSMComposeToolbar.h
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XSMComposeToolbarButtonType) {
    XSMComposeToolbarButtonTypePicture,
    XSMComposeToolbarButtonTypeTrend,
    XSMComposeToolbarButtonTypeMention,
    XSMComposeToolbarButtonTypeEmotion,
    XSMComposeToolbarButtonTypeCamera
};

@class XSMComposeToolbar;

@protocol XSMComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(XSMComposeToolbar *)composeToolbar didClickButton:(XSMComposeToolbarButtonType)buttonType;
@end

@interface XSMComposeToolbar : UIView

@property (nonatomic, weak) id<XSMComposeToolbarDelegate> delegate;
@property (nonatomic, assign) BOOL showKeyboard;
@property (nonatomic, weak) UIButton *emotionButton;

@end
