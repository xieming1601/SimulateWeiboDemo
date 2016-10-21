//
//  XSMDiscoveryViewController.m
//  Weibo
//
//  Created by xsm on 2016/10/12.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMDiscoveryViewController.h"
#import "XSMSearchBar.h"

@interface XSMDiscoveryViewController ()

@end

@implementation XSMDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加搜索框，用自定义的
    XSMSearchBar *searchBar = [XSMSearchBar searchBar];
    //设置大小
    searchBar.height = 30;
    searchBar.width = 320;
    //    UITextField *searchBar = [[UITextField alloc] init];
    //    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    //    searchBar.height = 30;
    //    searchBar.width = self.view.bounds.size.width;
    //
    //    UIImageView *searchIcon = [[UIImageView alloc] init];
    //    UIImage *image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    //    searchIcon.image = image;
    //    searchIcon.width = 30;
    //    searchIcon.height = 30;
    //    searchIcon.contentMode = UIViewContentModeCenter;
    //    searchBar.leftView = searchIcon;
    //    searchBar.leftViewMode = UITextFieldViewModeAlways;
    //    searchBar.placeholder = @"请输入搜索条件";
    //    searchBar.font = [UIFont systemFontOfSize:13];
    
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
