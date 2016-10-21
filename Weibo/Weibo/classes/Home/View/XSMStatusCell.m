//
//  XSMStatusCell.m
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMStatusCell.h"
#import "XSMStatusFrame.h"
#import "XSMStatus.h"
#import "XSMUser.h"
#import "XSMPhoto.h"
#import "UIImageView+WebCache.h"

#define XSMNameFont [UIFont systemFontOfSize:15]
#define XSMTextFont [UIFont systemFontOfSize:16]

@implementation XSMStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"status";
    XSMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XSMStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIImageView *userImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:userImageView];
        self.userImageView = userImageView;
        
        UILabel *userLabel = [[UILabel alloc] init];
        userLabel.font = XSMNameFont;
        [self.contentView addSubview:userLabel];
        self.userLabel = userLabel;
        
        UIImageView *verifiedImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:verifiedImageView];
        self.verifiedImageView = verifiedImageView;
        
        UILabel *createDate = [[UILabel alloc] init];
        [self.contentView addSubview:createDate];
        self.createDate = createDate;
        
        UILabel *source = [[UILabel alloc] init];
        [self.contentView addSubview:source];
        self.source = source;
        
        UILabel *text = [[UILabel alloc] init];
        text.font = XSMTextFont;
        text.numberOfLines = 0;
        [self.contentView addSubview:text];
        self.text = text;
        
        UIImageView *profileImage = [[UIImageView alloc] init];
        [self.contentView addSubview:profileImage];
        self.profileImageView = profileImage;
        
        UIButton *retweetedView = [[UIButton alloc] init];
        [retweetedView setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background"] forState:UIControlStateNormal];
        [retweetedView setBackgroundImage:[UIImage imageNamed:@"timeline_retweet_background_highlighted"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:retweetedView];
        self.retweetedView = retweetedView;
        
        UILabel *retweetedContent = [[UILabel alloc] init];
        retweetedContent.font = XSMTextFont;
        retweetedContent.numberOfLines = 0;
        [self.retweetedView addSubview:retweetedContent];
        self.retweetedContent = retweetedContent;
        
        UIImageView *retweetedImage = [[UIImageView alloc] init];
        [self.retweetedView addSubview:retweetedImage];
        self.retweetedImage = retweetedImage;
    }
    
    return self;
}

- (void)setStatusFrame:(XSMStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    //给子控件赋值
    [self settingData];
    //设置子控件frame
    [self settingFrame];
}

- (void)settingData {
    XSMStatus *status = self.statusFrame.status;
    XSMUser *user = status.user;
    
    self.userLabel.text = status.user.name;
    
    if (user.verified) {
        [self.verifiedImageView setImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
    }
    self.text.text = status.text;
    if (status.pic_urls.count) {
        /** 只显示第一张图 */
        XSMPhoto *photo = [status.pic_urls firstObject];
        [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.profileImageView.hidden = NO;
    } else {
        self.profileImageView.hidden = YES;
    }
    
    XSMStatus *retweetedStatus = status.retweeted_status;
    if (retweetedStatus) {
        self.retweetedContent.text = [NSString stringWithFormat:@"%@ : %@", retweetedStatus.user.name, retweetedStatus.text];
        if (retweetedStatus.pic_urls.count) {
            XSMPhoto *photo = [retweetedStatus.pic_urls firstObject];
            [self.retweetedImage sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetedImage.hidden = NO;
        } else {
            self.retweetedImage.hidden = YES;
        }
        self.retweetedView.hidden = NO;
    } else {
        self.retweetedView.hidden = YES;
    }
}

- (void)settingFrame {
    XSMStatus *status = self.statusFrame.status;
    XSMUser *user = status.user;
    
    self.userImageView.frame = self.statusFrame.userImageFrame;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.userLabel.frame = self.statusFrame.userNameFrame;
    
    if (user.verified) {
        self.verifiedImageView.frame = self.statusFrame.verifiedFrame;
    }
    self.text.frame = self.statusFrame.textFrame;
    
    if (status.pic_urls.count) {
        self.profileImageView.frame = self.statusFrame.profileImageFrame;
    }
    
    XSMStatus *retweetedStatus = status.retweeted_status;
    if (retweetedStatus) {
        self.retweetedView.frame = self.statusFrame.retweetedFrame;
        self.retweetedContent.frame = self.statusFrame.retweetedContentFrame;
        if (retweetedStatus.pic_urls.count) {
            self.retweetedImage.frame = self.statusFrame.retweetedImageFrame;
        }
    }
}

@end
