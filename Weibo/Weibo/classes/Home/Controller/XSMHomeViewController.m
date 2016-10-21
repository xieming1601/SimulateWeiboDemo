//
//  XSMHomeViewController.m
//  Weibo
//
//  Created by xsm on 2016/10/12.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMHomeViewController.h"
#import "XSMDropdownContentViewController.h"
#import "XSMStatusCell.h"
#import "AFNetworking.h"
#import "XSMAcountTool.h"
#import "UIImageView+WebCache.h"
#import "XSMStatus.h"
#import "XSMUser.h"
#import "XSMStatusFrame.h"
#import "HotSearchViewController.h"

@interface XSMHomeViewController ()

@end

@implementation XSMHomeViewController


-(NSMutableArray *) statuses{
    if(!_statuses){
        _statuses = [[NSMutableArray alloc] init];
    }
    return _statuses;
}

-(NSMutableArray *) statusFramesWithStatuses:(NSMutableArray *) statuses{
    NSMutableArray *models = [NSMutableArray array];
    for(XSMStatus *status in statuses){
        XSMStatusFrame *statusFrame = [[XSMStatusFrame alloc] init];
        statusFrame.status = status;
        [models addObject:statusFrame];
    }
    return models;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*设置左右barButtonItem */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftButtonClick) image:@"navigationbar_friendattention" highlightImage:@"navigationbar_friendattention_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightButtonClick) image:@"navigationbar_icon_radar" highlightImage:@"navigationbar_icon_radar_highlighted"];
    
    /*创建可点击的titleView*/
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    
    //设置title， 图片
    [titleButton setTitle:@"主页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0);
    [titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
    //添加顶部搜索条
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    self.searchController.searchResultsUpdater = self;
//    self.searchController.searchBar.placeholder = @"大家都在搜： 男子20万助女友买车";
//    self.searchController.searchBar.contentMode = UIViewContentModeLeft;
//    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchBar = [[XSMLeftSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,40)];
    self.searchBar.placeholder = @"大家都在搜： 男子20万助女友买车";
    self.searchBar.tintColor = [UIColor clearColor];
    [self.searchBar setHasCentredPlaceholder:NO];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;

    //添加刷新控件
    [self setRefresh];
    
//    //获取未读微博数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setUnreadCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setUnreadCount {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //请求参数
    XSMAccount *account = [XSMAcountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    //发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //拿到返回的未读微博数，返回的是NSNumber, 这里使用description转成NSString
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            //设置桌面图标的右上角标
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败--%@", error);
    }];
}

- (void)setRefresh {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:refreshControl];
    
    //进来就刷新
    [refreshControl beginRefreshing];
    [self refreshStateChange:refreshControl];
}

- (void)refreshStateChange: (UIRefreshControl *)control {
    NSLog(@"refresh state value changed");
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    XSMAccount *account = [XSMAcountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    XSMStatus *latestStatus = [self.statuses firstObject];
    if (latestStatus) {
        params[@"since_id"] = latestStatus.idstr;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取微博成功 %@", responseObject);
        //先获取字典数组
        NSArray *dictArray = (NSArray *)responseObject[@"statuses"];
        NSArray *newStatuses = [XSMStatus objectArrayWithKeyValuesArray:dictArray];
        
        //将新数据添加到数组
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        //转化成VSAStatusFrame数组
        self.statusFrames = [self statusFramesWithStatuses:self.statuses];
        
        //加载结束后，重新加载到tableView的cell中显示
        [self.tableView reloadData];
        
        //结束刷新
        [control endRefreshing];
        
        //显示更新了多少条微博
        [self showUpdatedState: newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取微博失败 %@", error);
        [control endRefreshing];
    }];
}

- (void)showUpdatedState: (CGFloat)count {
    //将tabBarItem显示的数字清空
    self.tabBarItem.badgeValue = nil;
    //1. 创建一个label用来显示提示信息
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 45;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (count) {
        label.text = [NSString stringWithFormat:@"更新了%d条数据", (int)count];
    } else {
        label.text = [NSString stringWithFormat:@"没有新数据，稍后再试"];
    }
    
    //2. 设置初始位置
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //3. 设置动画，用1秒时间向下移动label.height的距离，显示出来
    CGFloat interval = 1.0;
    [UIView animateWithDuration:interval animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //停1秒，让用户看清楚
        [NSThread sleepForTimeInterval:1.0];
        //再使用1秒的时间，回到初始位置
        CGFloat delay = 1.0;
        [UIView animateWithDuration:interval delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)leftButtonClick {
    NSLog(@"home left button click");
}

- (void)rightButtonClick {
    NSLog(@"home right button click");
}

- (void)titleButtonClick {

    //创建dropdownMenu
    XSMDropdownMenu *menu = [XSMDropdownMenu dropdownMenu];
    menu.delegate = self;
    
    XSMDropdownContentViewController *dropdownContentVC = [[XSMDropdownContentViewController alloc] init];
    //注意顺序，要先设置宽高，在设置contentVC
    dropdownContentVC.view.width = 170;
    dropdownContentVC.view.height = 180;
    menu.contentVC = dropdownContentVC;
    
    [menu showFrom:self.titleButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    XSMStatusCell *cell = [XSMStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMStatusFrame *statusFrame =  self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

#pragma mark - XSMDropdownMenuDelegate

- (void)dropdownMenuDidDismiss:(XSMDropdownMenu *)dropdownMenu {
    self.titleButton.selected = NO;
}

- (void)dropdownMenuDidShow:(XSMDropdownMenu *)dropdownMenu {
    self.titleButton.selected = YES;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (!searchController.active) {
        NSLog(@"no active");
        return;
    }
    
    NSLog(@"active");
    
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    UINavigationController* nc = [[UINavigationController alloc] init];
    HotSearchViewController *hsvc = [[HotSearchViewController alloc] init];
    [nc addChildViewController:hsvc];
    
    [self presentViewController:nc animated:NO completion:nil];

    return YES;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
