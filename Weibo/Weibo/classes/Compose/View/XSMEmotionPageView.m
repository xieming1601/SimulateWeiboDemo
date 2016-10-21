//
//  XSMEmotionPageView.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMEmotionPageView.h"
#import "XSMEmotion.h"
#import "XSMEmotionPopView.h"
#import "XSMEmotionButton.h"
#import "XSMGlobal.h"

@implementation XSMEmotionPageView

-(XSMEmotionPopView *)popView {
    if (!_popView) {
        _popView = [XSMEmotionPopView popView];
    }
    
    return _popView;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    for (int i = 0; i < emotions.count; i++) {
        XSMEmotion *emotion  = emotions[i];
        XSMEmotionButton *btn = [[XSMEmotionButton alloc] init];
        btn.emotion = emotion;
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //添加删除按钮
    UIButton *delBtn = [[UIButton alloc] init];
    [delBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:delBtn];
    self.delButton = delBtn;
    
    //添加长按手势
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 20;
    NSUInteger count = self.emotions.count;
    CGFloat width = (self.width - padding * 2) / XSMEmotionMaxCols;
    CGFloat height = (self.height - padding) / XSMEmotionMaxRows;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        NSUInteger row = i / XSMEmotionMaxCols;
        NSUInteger column = i % XSMEmotionMaxCols;
        CGFloat x = column * width + padding;
        CGFloat y = row * height + padding;
        
        //        if (i == self.subviews.count - 1) {
        //            x = (XSMEmotionMaxCols - 1) * width + padding;
        //            y = (XSMEmotionMaxRows - 1) * height + padding;
        //        }
        btn.width = width;
        btn.height = height;
        btn.x = x;
        btn.y = y;
    }
    
    //设置delButton位置
    self.delButton.width = width;
    self.delButton.height = height;
    self.delButton.x = self.width - width - padding;
    self.delButton.y = self.height - height;
}

#pragma mark - 监听事件
- (void)btnClick:(XSMEmotionButton *)btn {
    //    [self addSubview:self.popView];
    [self.popView showFrom:btn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[XSMSelectedEmotionButtonKey] = btn.emotion;
    
    //通知，让controller 接收到，因为textView在controll中
    [[NSNotificationCenter defaultCenter] postNotificationName:XSMEmotionButtonDidSelectNotification object:nil userInfo:userInfo];
    
}

- (void)delBtnClick:(UIButton *)btn {
    [[NSNotificationCenter defaultCenter] postNotificationName:XSMDeleteButtonDidSelectNotification object:nil];
}

- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    XSMEmotionButton *button = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            [self.popView showFrom:button];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.popView showFrom:button];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.popView removeFromSuperview];
            
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            userInfo[XSMSelectedEmotionButtonKey] = button.emotion;
            
            //通知，让controller 接收到，因为textView在controll中
            [[NSNotificationCenter defaultCenter] postNotificationName:XSMEmotionButtonDidSelectNotification object:nil userInfo:userInfo];
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            
            break;
        }
        default:
            break;
    }
}

- (XSMEmotionButton *)emotionButtonWithLocation:(CGPoint)location {
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        XSMEmotionButton *button = self.subviews[i];
        if (CGRectContainsPoint(button.frame, location)) {
            return button;
        }
    }
    
    return nil;
}

@end
