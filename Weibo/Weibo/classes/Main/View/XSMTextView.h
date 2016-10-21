//
//  XSMTextView.h
//  Weibo
//
//  Created by xsm on 2016/10/14.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSMTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, weak) UILabel *placeholderLabel;

@end
