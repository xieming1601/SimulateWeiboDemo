//
//  XSMGlobal.h
//  Weibo
//
//  Created by xsm on 2016/10/12.
//  Copyright © 2016年 xsm. All rights reserved.
//

#ifndef XSMGlobal_h
#define XSMGlobal_h

#define XSMRandomColor XSMColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
#define XSMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//通知
#define XSMEmotionButtonDidSelectNotification @"XSMEmotionButtonDidSelectNotification"
#define XSMSelectedEmotionButtonKey @"XSMSelectedEmotionButtonKey"
#define XSMDeleteButtonDidSelectNotification @"XSMDeleteButtonDidSelectNotification"
#define XSMDeleteButtonKey @"XSMDeleteButtonKey"

#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"


#endif /* XSMGlobal_h */
