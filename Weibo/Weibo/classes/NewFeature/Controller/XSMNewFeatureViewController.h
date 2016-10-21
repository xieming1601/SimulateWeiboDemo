//
//  XSMNewFeatureViewController.h
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XSMImageCount 4

@interface XSMNewFeatureViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *lastPage;
@property (nonatomic, strong) UIButton *openButton;

@end
