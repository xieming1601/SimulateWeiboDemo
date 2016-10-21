//
//  XSMNewFeatureViewController.m
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMNewFeatureViewController.h"
#import "XSMMainViewController.h"
#import "XSMGlobal.h"

@interface XSMNewFeatureViewController ()

@end

@implementation XSMNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = self.view.frame;
    scrollview.contentSize = CGSizeMake(XSMImageCount * scrollview.frame.size.width, 0);
    self.scrollView = scrollview;
    scrollview.bounces = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    for(int i = 0; i < XSMImageCount; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * imageW, 0, imageW, imageH)];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        
        //设置最后一张图片中的按钮
        if(i == (XSMImageCount - 1)){
            imageView.userInteractionEnabled = YES;
            
            UIButton *openButton = [[UIButton alloc] init];
            [openButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [openButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            [openButton setTitle:@"开启微博" forState:UIControlStateNormal];
            openButton.translatesAutoresizingMaskIntoConstraints = NO;
//            openButton.size = openButton.currentBackgroundImage.size;
            openButton.backgroundColor = [UIColor redColor];
            [imageView addSubview:openButton];
            [openButton addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
            self.openButton = openButton;
            
            //使用autoLayout布局 设置openbutton的宽度、高度、以及水平居中，距离下边50
//            NSLayoutConstraint * obtnW = [NSLayoutConstraint constraintWithItem:openButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:200.0];
//            //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
//            [openButton addConstraint:obtnW];
//            
//            NSLayoutConstraint * obtnH = [NSLayoutConstraint constraintWithItem:openButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:200.0];
//            //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
//            [openButton addConstraint:obtnH];
            
            NSLayoutConstraint * obtnCenterX = [NSLayoutConstraint constraintWithItem:openButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0];
            //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
            [imageView addConstraint:obtnCenterX];

            NSLayoutConstraint * obtnBottom = [NSLayoutConstraint constraintWithItem:openButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-150.0];
            //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
            [imageView addConstraint:obtnBottom];
            
            

        }
        
        
    }
    
    //添加PageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = XSMImageCount;
    pageControl.currentPageIndicatorTintColor = XSMColor(235, 45, 23);
    pageControl.pageIndicatorTintColor = XSMColor(180, 180, 180);
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
//    pageControl.centerX = self.scrollView.width * 0.5;
//    pageControl.centerY = self.scrollView.height - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    NSLayoutConstraint * pcCenterX = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0];
    //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
    [self.view addConstraint:pcCenterX];
    
    NSLayoutConstraint * pcBottom = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-50.0];
    //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
    [self.view addConstraint:pcBottom];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    XSMMainViewController *mainVC = [[XSMMainViewController alloc] init];
    [window setRootViewController:mainVC];
}

#pragma mark - UISCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double offSetX = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    
    int currentPage = (int)(offSetX + 0.5);
    self.pageControl.currentPage = currentPage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
