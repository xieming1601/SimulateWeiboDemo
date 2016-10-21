//
//  XSMEmotionPopView.h
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSMEmotion, XSMEmotionButton;

@interface XSMEmotionPopView : UIView

@property (weak, nonatomic) IBOutlet XSMEmotionButton *emotionBtn;

+ (instancetype)popView;
- (void)showFrom:(XSMEmotionButton *)btn;

@end
