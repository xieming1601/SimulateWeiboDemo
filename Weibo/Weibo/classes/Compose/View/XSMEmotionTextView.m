//
//  XSMEmotionTextView.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMEmotionTextView.h"
#import "XSMEmotion.h"
#import "XSMGlobal.h"

@implementation XSMEmotionTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)insertEmotion:(XSMEmotion *)emotion {
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        //        [self.textView insertText:emotion.chs]; //实际上发送微博要的是emotion.chs [哈哈]
        
        //图片attach
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:emotion.png];
        CGFloat fontHeight = self.font.lineHeight;
        attachment.bounds = CGRectMake(0, -4, fontHeight, fontHeight);
        NSAttributedString *attributed = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [self insertAttributedText:attributed settingFontBlock:^(NSMutableAttributedString *attributedString) {
            //拿到所有内容，设置大小
            [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedString.length)];
        }];
    }
}


@end
