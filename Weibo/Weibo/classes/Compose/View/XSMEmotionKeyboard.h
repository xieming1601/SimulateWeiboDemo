//
//  XSMEmotionKeyboard.h
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSMEmotionCollection.h"
#import "XSMEmotionTabBar.h"
#import "XSMEmotion.h"
#import "MJExtension.h"
#import "XSMGlobal.h"

@interface XSMEmotionKeyboard : UIView

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, strong) XSMEmotionCollection *recentCollection;
@property (nonatomic, strong) XSMEmotionCollection *defaultCollection;
@property (nonatomic, strong) XSMEmotionCollection *emojiCollection;
@property (nonatomic, strong) XSMEmotionCollection *lxhCollection;
@property (nonatomic, strong) XSMEmotionTabBar *tabBar;

@end
