//
//  XSMEmotionKeyboard.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMEmotionKeyboard.h"

@implementation XSMEmotionKeyboard

#pragma mark - 懒加载
- (XSMEmotionCollection *)recentCollection {
    if (!_recentCollection) {
        self.recentCollection = [[XSMEmotionCollection alloc] init];
        //        self.recentCollection.backgroundColor = XSMRandomColor;
    }
    
    return _recentCollection;
}

- (XSMEmotionCollection *)defaultCollection {
    if (!_defaultCollection) {
        self.defaultCollection = [[XSMEmotionCollection alloc] init];
        //        self.defaultCollection.backgroundColor = XSMRandomColor;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultCollection.emotions = [XSMEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    
    return _defaultCollection;
}

- (XSMEmotionCollection *)emojiCollection {
    if (!_emojiCollection) {
        self.emojiCollection = [[XSMEmotionCollection alloc] init];
        //        self.emojiCollection.backgroundColor = XSMRandomColor;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiCollection.emotions = [XSMEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    
    return _emojiCollection;
}

- (XSMEmotionCollection *)lxhCollection {
    if (!_lxhCollection) {
        self.lxhCollection = [[XSMEmotionCollection alloc] init];
        //        self.lxhCollection.backgroundColor = XSMRandomColor;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhCollection.emotions = [XSMEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]] ;
    }
    
    return _lxhCollection;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //1. contentView
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        //2. tabBar
        XSMEmotionTabBar *tabBar = [[XSMEmotionTabBar alloc] init];
        self.tabBar = tabBar;
        tabBar.delegate = self;
        //        tabBar.backgroundColor = XSMRandomColor;
        [self addSubview:tabBar];
        //
        //        XSMEmotionCollection *collection = [[XSMEmotionCollection alloc] init];
        //        self.collection = collection;
        //        collection.backgroundColor = XSMRandomColor;
        //        [self addSubview:collection];
    }
    
    return self;
}

- (void)layoutSubviews {
    CGFloat tabBarW = self.width;
    CGFloat tabBarH = 37;
    CGFloat tabBarX = 0;
    CGFloat tabBarY = self.height - tabBarH;
    self.tabBar.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
    
    //contentView
    CGFloat contentW = self.width;
    CGFloat contentH = tabBarY;
    CGFloat contentX = 0;
    CGFloat contentY = 0;
    self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    //contentView子控件的frame
    XSMEmotionCollection *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
}

#pragma mark - XSMEmotionTabBarDelegate
- (void)tabBarDidClickButton:(XSMEmotionTabBar *)tabBar button:(XSMEmotionTabBarButtonType)type {
    
    //清空contentView中子控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (type) {
        case XSMEmotionTabBarButtonTypeRecent:{
            [self.contentView addSubview:self.recentCollection];
            break;
        }
        case XSMEmotionTabBarButtonTypeDefault:{
            [self.contentView addSubview:self.defaultCollection];
            break;
        }
        case XSMEmotionTabBarButtonTypeEmoji: {
            [self.contentView addSubview:self.emojiCollection];
            break;
        }
        case XSMEmotionTabBarButtonTypeLang: {
            [self.contentView addSubview:self.lxhCollection];
            break;
        }
        default:
            break;
    }
    
    //刷新控件布局
    [self setNeedsLayout];
}

@end
