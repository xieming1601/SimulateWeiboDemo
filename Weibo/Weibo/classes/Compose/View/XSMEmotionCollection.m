//
//  XSMEmotionCollection.m
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMEmotionCollection.h"
#import "XSMEmotionPageView.h"
#import "XSMGlobal.h"

@implementation XSMEmotionCollection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //1. scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        //这两个属于scrollView的subview, 在使用scrollView.subviews时会有影响，在这把它去掉
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //2. pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        //让它不受控制
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        //直接修改图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        self.pageControl = pageControl;
    }
    
    return self;
}

-(void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    //1. 设置page number
    NSUInteger pageCount = (emotions.count + XSMEmotionPageSize - 1) / XSMEmotionPageSize;
    self.pageControl.numberOfPages = pageCount;
    
    //2. scrollView
    for (int i = 0; i< pageCount; i++) {
        //每一页表情使用一个单独的view显示
        XSMEmotionPageView *pageView = [[XSMEmotionPageView alloc] init];
        [self.scrollView addSubview:pageView];
        
        //每一页的表情范围
        NSRange range;
        range.location = i * XSMEmotionPageSize;
        //最后一页剩余的个数
        NSUInteger left = emotions.count - range.location;
        if (left > XSMEmotionPageSize) {
            range.length = XSMEmotionPageSize;
        } else {
            range.length = left;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
    }
}

- (void)layoutSubviews {
    //1. pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 30;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //2. scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - self.pageControl.height;
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    
    //3. scrollView子控件的frame
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        XSMEmotionPageView *pageView = (XSMEmotionPageView *)self.scrollView.subviews[i];
        pageView.x = i * self.scrollView.width;
        pageView.y = 0;
        pageView.width = self.scrollView.width;
        pageView.height = self.scrollView.height;
    }
    
    //scrollView contentSize
    CGFloat contentW = self.scrollView.width * count;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double offSetX = self.scrollView.contentOffset.x / self.scrollView.width;
    
    int currentPage = (int)(offSetX + 0.5);
    self.pageControl.currentPage = currentPage;
}

@end
