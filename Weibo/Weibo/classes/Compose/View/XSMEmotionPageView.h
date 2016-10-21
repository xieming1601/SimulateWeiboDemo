//
//  XSMEmotionPageView.h
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSMEmotionPopView;

#define XSMEmotionMaxCols 7
#define XSMEmotionMaxRows 3
#define XSMEmotionPageSize (XSMEmotionMaxCols * XSMEmotionMaxRows - 1)

@interface XSMEmotionPageView : UIView

@property (nonatomic, strong) NSArray *emotions;
@property (nonatomic, strong) UIButton *delButton;
@property (nonatomic, strong) XSMEmotionPopView *popView;

@end
