//
//  HotSearchViewController.h
//  Weibo
//
//  Created by xsm on 2016/10/18.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSMLeftSearchBar.h"

typedef NS_OPTIONS(NSUInteger, XSMHotSearchType) {
    XSMHotSearchTypeNone = 1 << 0,
    XSMHotSearchTypeHot = 1 << 1,
    XSMHotSearchTypeFriend = 1 << 2,
    XSMHotSearchTypeAdvise = 1 << 3,
    XSMHotSearchTypeNew = 1 << 4,
};

@interface HotSearchViewController : UIViewController

@property (nonatomic, strong) XSMLeftSearchBar *searchBar;

@property (nonatomic, strong) NSArray *historyContent;
@property (nonatomic, strong) NSArray *hotSearchContent;

@end
