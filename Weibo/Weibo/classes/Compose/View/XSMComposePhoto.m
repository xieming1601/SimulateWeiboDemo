//
//  XSMComposePhoto.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMComposePhoto.h"

@implementation XSMComposePhoto

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
        CGFloat x = 10;
        CGFloat y = 200;
        CGFloat frameWH = 80;
        self.frame = CGRectMake(x, y, frameWH, frameWH);
        
    }
    return self;
}


@end
