//
//  XSMStatusCell.h
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XSMStatusFrame;

@interface XSMStatusCell : UITableViewCell

@property (nonatomic, weak) UIImageView *userImageView;
@property (nonatomic, weak) UILabel *userLabel;
@property (nonatomic, weak) UIImageView *verifiedImageView;
@property (nonatomic, weak) UILabel *createDate;
@property (nonatomic, weak) UILabel *source;
@property (nonatomic, weak) UILabel *text;
@property (nonatomic, weak) UIImageView *profileImageView;
@property (nonatomic, weak) UIButton *retweetedView;
@property (nonatomic, weak) UILabel *retweetedContent;
@property (nonatomic, weak) UIImageView *retweetedImage;

@property (nonatomic, strong) XSMStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
