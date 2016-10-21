//
//  XSMComposeToolbar.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMComposeToolbar.h"
#import "XSMGlobal.h"

@implementation XSMComposeToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setupButton:@"compose_toolbar_picture" highlightImage:@"compose_toolbar_picture_highlighted" type:XSMComposeToolbarButtonTypePicture];
        [self setupButton:@"compose_trendbutton_background" highlightImage:@"compose_trendbutton_background_highlighted" type:XSMComposeToolbarButtonTypeTrend];
        [self setupButton:@"compose_mentionbutton_background" highlightImage:@"compose_mentionbutton_background_highlighted" type:XSMComposeToolbarButtonTypeMention];
        self.emotionButton = [self setupButton:@"compose_emoticonbutton_background" highlightImage:@"compose_emoticonbutton_background_highlighted" type:XSMComposeToolbarButtonTypeEmotion];
        [self setupButton:@"compose_camerabutton_background" highlightImage:@"compose_camerabutton_background_highlighted" type:XSMComposeToolbarButtonTypeCamera];
    }
    
    return self;
}

- (void)setShowKeyboard:(BOOL)showKeyboard {
    _showKeyboard = showKeyboard;
    
    //默认是表情图标
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highlightImage = @"compose_emoticonbutton_background_highlighted";
    
    if (showKeyboard) {//显示成体统键盘图标
        image = @"compose_keyboardbutton_background";
        highlightImage = @"compose_keyboardbutton_background_highlighted";
        
    }
    
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
}

/**
 *  创建按钮方法
 */
- (UIButton *)setupButton:(NSString *)image highlightImage:(NSString *)highlightImage type:(XSMComposeToolbarButtonType)type {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [btn setTag:type];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}

@end
