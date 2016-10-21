//
//  XSMTabBar.m
//  Weibo
//
//  Created by xsm on 2016/10/12.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMTabBar.h"

@implementation XSMTabBar

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
        //
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置plusButton位置
    self.plusButton.centerX = self.bounds.size.width * 0.5;
    self.plusButton.centerY = self.bounds.size.height * 0.5;
    
    //设置其他4个UITabBarButton的位置和按钮
    CGFloat tabBarButtonCount = 5;
    CGFloat childWidth = self.bounds.size.width / tabBarButtonCount;
    CGFloat subViewIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.x = subViewIndex * childWidth;
            subViewIndex++;
            
            if (subViewIndex == 2) {
                subViewIndex++;
            }
        }
    }
}

- (UIButton *)plusButton {
    if (!_plusButton) {
        _plusButton = [[UIButton alloc] init];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        _plusButton.size = _plusButton.currentBackgroundImage.size;
        [self addSubview:_plusButton];
        
        self.plusButton = _plusButton;
        //添加事件
        [_plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _plusButton;
}

- (void)plusButtonClick {
    if ([self.delegate1 respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate1 tabBarDidClickPlusButton:self];
    }
}

@end
