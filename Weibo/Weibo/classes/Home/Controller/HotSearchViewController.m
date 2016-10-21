//
//  HotSearchViewController.m
//  Weibo
//
//  Created by xsm on 2016/10/18.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "HotSearchViewController.h"

@interface HotSearchViewController ()

@end

@implementation HotSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
    self.navigationItem.hidesBackButton = YES;
    
    [self initContent];
    
    [self initUI];
    
    
}

-(void) initContent{
    //未能从网络获取内容，这里人为写一些数据
    if(!self.historyContent){
        self.historyContent = @[@"不管他送的iPhone7多丑",@"食客用银圆抵账"];
    }
    
    if(!self.hotSearchContent){
        self.hotSearchContent = @[
                                  @{@"不管他送的iPhone7多丑":@"title",
                                    @"Hot":@"type"},
                                  @{@"李小男结局":@"title",
                                    @"Hot":@"type"},
                                  @{@"美食大V秀":@"title",
                                    @"Advise":@"type"},
                                  @{@"七月与安生":@"title",
                                    @"Friend":@"type"},
                                  @{@"张天爱 金投赏":@"title",
                                    @"None":@"type"},
                                  @{@"王源 最美的时光":@"title",
                                    @"None":@"type"},
                                  @{@"梨涡妹妹":@"title",
                                    @"Hot":@"type"},
                                  @{@"王宝强离婚案开庭":@"title",
                                    @"New":@"type"},
                                  @{@"穿秋裤会丧失抗寒基因":@"title",
                                    @"None":@"type"},
                                  @{@"更多热搜":@"title",
                                    @"More":@"type"},
                                  ];
    }
}

-(void) initUI{
    
    //初始化导航栏内的搜索条
    self.searchBar = [[XSMLeftSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,40)];
    self.searchBar.placeholder = @"男子20万助女友买车";
    [self.searchBar setHasCentredPlaceholder:NO];
    [self.searchBar setImage:[UIImage imageNamed:@"searchbar_textfield_down_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.showsCancelButton = YES;
    [self.searchBar becomeFirstResponder];
    
    self.navigationItem.titleView = self.searchBar;
    
    //初始化用于查看搜索历史的view
    UIView *historyView = [[UIView alloc] init];
    historyView.translatesAutoresizingMaskIntoConstraints = NO;
    historyView.backgroundColor =[UIColor redColor];
    [self.view addSubview:historyView];
    
    if(self.historyContent.count > 2){
        
        
    }else if(self.historyContent.count >0){
        NSLayoutConstraint * topHV = [NSLayoutConstraint constraintWithItem:historyView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:64.0];
        [self.view addConstraint:topHV];
        
        NSLayoutConstraint * widthHV = [NSLayoutConstraint constraintWithItem:historyView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:self.view.frame.size.width];
        [self.view addConstraint:widthHV];
        
        NSLayoutConstraint * heightHV = [NSLayoutConstraint constraintWithItem:historyView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:44 * self.historyContent.count + 12];
        [self.view addConstraint:heightHV];
        
        
    }else{
        historyView.frame = CGRectMake(0, 46, self.view.frame.size.width, 0);
    }
    
    [self.view addSubview:historyView];
    
    
    
//    NSLayoutConstraint * topSB = [NSLayoutConstraint constraintWithItem:self.searchBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:20.0];
//    //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
//    [self.view addConstraint:topSB];
//    
//    NSLayoutConstraint * leftSB = [NSLayoutConstraint constraintWithItem:self.searchBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0];
//    //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
//    [self.view addConstraint:leftSB];
//    
//    NSLayoutConstraint * widthSB = [NSLayoutConstraint constraintWithItem:self.searchBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:self.view.bounds.size.width];
//    //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
//    [self.view addConstraint:widthSB];
//    
//    NSLayoutConstraint * heightSB = [NSLayoutConstraint constraintWithItem:self.searchBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:40.0];
//    //只有在没有参照控件的情况下，约束才加到自身，不然加到父控件上
//    [self.view addConstraint:heightSB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
