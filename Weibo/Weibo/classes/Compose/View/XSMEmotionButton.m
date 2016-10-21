//
//  XSMEmotionButton.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMEmotionButton.h"
#import "XSMEmotion.h"
#import "XSMGlobal.h"

@implementation XSMEmotionButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}

-(void)setEmotion:(XSMEmotion *)emotion {
    _emotion = emotion;
    
    if (_emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (_emotion.code) {
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
}

@end
