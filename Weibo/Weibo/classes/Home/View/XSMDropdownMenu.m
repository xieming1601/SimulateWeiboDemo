//
//  XSMDropdownMenu.m
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMDropdownMenu.h"

@implementation XSMDropdownMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)dropdownMenu {
    return [[self alloc] init];
}

- (UIImageView *)containerView {
    if (_containerView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"popover_background"];
        imageView.width = 217;
        imageView.height = 200;
        //设置imageView中的控件可以接收用户交互
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        //赋值给self.containerView
        self.containerView = imageView;
    }
    
    return _containerView;
}

- (void)setContent:(UIView *)content {
    _content = content;
    
    _content.x = 10;
    _content.y = 15;
    
    //设置containerView的大小
    self.containerView.width = CGRectGetMaxX(_content.frame) + 10;
    self.containerView.height = CGRectGetMaxY(_content.frame) + 10;
    _content.backgroundColor = [UIColor grayColor];
    
    [self.containerView addSubview:_content];
}

- (void)dismiss {
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)showFrom:(UIView *)from {
    // 这样获得的窗口，是目前显示在屏幕最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    //    self.backgroundColor = [UIColor greenColor];
    CGRect fromFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(fromFrame);
    self.containerView.y = CGRectGetMaxY(fromFrame);
    [window addSubview:self];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}



@end
