//
//  XSMMainViewController.m
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMMainViewController.h"
#import "XSMHomeViewController.h"
#import "XSMMessageViewController.h"
#import "XSMDiscoveryViewController.h"
#import "XSMProfileViewController.h"
#import "XSMComposeViewController.h"
#import "XSMNaviViewController.h"



@interface XSMMainViewController ()

@end

@implementation XSMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置tabBarItems
    XSMHomeViewController *homeVC = [[XSMHomeViewController alloc] init];
    [self addChildWithVC:homeVC title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    XSMMessageViewController *messageVC = [[XSMMessageViewController alloc] init];
    [self addChildWithVC:messageVC title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    XSMDiscoveryViewController *discoveryVC = [[XSMDiscoveryViewController alloc] init];
    [self addChildWithVC:discoveryVC title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    XSMProfileViewController *profileVC = [[XSMProfileViewController alloc] init];
    [self addChildWithVC:profileVC title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    XSMTabBar *tabBar = [[XSMTabBar alloc] init];
    tabBar.delegate1 = self;
    
    //对于标记为readonly的属性赋值 可以使用 kvc的方式
    [self setValue:tabBar forKeyPath:@"tabBar"];

}

- (void)addChildWithVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    //包装一层NavigationController
    XSMNaviViewController *naviVC = [[XSMNaviViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:naviVC];
    //    childVC.tabBarItem.title = title;
    //可以同时设置navigation和tabbar 的title
    childVC.title = title;
    
    //去掉image图片的渲染，以本色出演
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    childVC.view.backgroundColor = VSARandomColor;
    
    //设置字体
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = XSMColor(123, 123, 123);
    [childVC.tabBarItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSMutableDictionary *selectedAttributes = [NSMutableDictionary dictionary];
    selectedAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
}

#pragma mark - VSATabBarDelegate
- (void)tabBarDidClickPlusButton:(UITabBar *)tabBar {
    //跳转到发微博页面
    XSMComposeViewController *composeVC = [[XSMComposeViewController alloc] init];
    XSMNaviViewController *naviVC = [[XSMNaviViewController alloc] initWithRootViewController:composeVC];
    [self presentViewController:naviVC animated:YES completion:nil];
    /*
     UIViewController *vc = [[UIViewController alloc] init];
     vc.view.backgroundColor = [UIColor blueColor];
     UIButton *backButton = [[UIButton alloc] init];
     [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
     backButton.size = backButton.currentBackgroundImage.size;
     backButton.centerX = vc.view.bounds.size.width * 0.5;
     backButton.centerY = vc.view.bounds.size.height * 0.5;
     [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
     [vc.view addSubview:backButton];
     self.vc = vc;
     [self presentViewController:vc animated:YES completion:nil];
     */
}

- (void)backClick {
    [self.vc dismissViewControllerAnimated:YES completion:nil];
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
