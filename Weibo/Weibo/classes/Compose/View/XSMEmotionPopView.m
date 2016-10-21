//
//  XSMEmotionPopView.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMEmotionPopView.h"
#import "XSMEmotionButton.h"
#import "XSMEmotion.h"
#import "XSMGlobal.h"

@implementation XSMEmotionPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)popView {
    XSMEmotionPopView *popView = [[XSMEmotionPopView alloc] init];
    return popView;
}

- (void)showFrom:(XSMEmotionButton *)btn {
    if (!btn) {
        return;
    }
    self.emotionBtn.emotion = btn.emotion;
    
    //获取最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    CGFloat y = CGRectGetMidY(btnFrame) - self.height;
    CGFloat x = CGRectGetMidX(btnFrame);
    self.y = y;
    self.centerX = x;
}


@end
