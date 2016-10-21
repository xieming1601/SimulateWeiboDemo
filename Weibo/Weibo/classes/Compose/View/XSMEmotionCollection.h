//
//  XSMEmotionCollection.h
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSMEmotionCollection : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *emotions;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic ,weak) UIScrollView *scrollView;

@end
