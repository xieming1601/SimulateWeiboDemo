//
//  XSMEmotionTabBar.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMEmotionTabBar.h"
#import "XSMGlobal.h"

@implementation XSMEmotionTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self btnWithTitle:@"最近" type:XSMEmotionTabBarButtonTypeRecent];
        [self btnWithTitle:@"默认" type:XSMEmotionTabBarButtonTypeDefault];
        [self btnWithTitle:@"Emoji" type:XSMEmotionTabBarButtonTypeEmoji];
        [self btnWithTitle:@"浪小花" type:XSMEmotionTabBarButtonTypeLang];
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 显示文字
 *  @param type  按钮tag
 *
 *  @return 按钮
 */
- (UIButton *)btnWithTitle:(NSString *)title type:(XSMEmotionTabBarButtonType)type {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTag:type];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    //设置字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    //设置字体颜色
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    //设置背景颜色
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *highlightImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_right_normal";
        highlightImage = @"compose_emotion_table_right_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_left_normal";
        highlightImage = @"compose_emotion_table_left_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateDisabled];
    return btn;
}

- (void)layoutSubviews {
    //不要忘记调用super方法
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
    }
}

#pragma mark - 重写方法
- (void)setDelegate:(id<XSMEmotionTabBarDelegate>)delegate {
    _delegate = delegate;
    
    UIButton *btn = (UIButton *)[self viewWithTag:XSMEmotionTabBarButtonTypeDefault];
    [self btnClick:btn];
}

#pragma mark - 监听事件
- (void)btnClick:(UIButton *)btn {
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickButton:button:)]) {
        [self.delegate tabBarDidClickButton:self button:btn.tag];
    }
}


@end
