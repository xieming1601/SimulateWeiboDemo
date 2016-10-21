//
//  XSMStatusFrame.h
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XSMStatus;

@interface XSMStatusFrame : NSObject

@property (nonatomic, assign) CGRect userImageFrame;
@property (nonatomic, assign) CGRect userNameFrame;
@property (nonatomic, assign) CGRect verifiedFrame;
@property (nonatomic, assign) CGRect createDateFrame;
@property (nonatomic, assign) CGRect sourceFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect profileImageFrame;
@property (nonatomic, assign) CGRect retweetedFrame;
@property (nonatomic, assign) CGRect retweetedContentFrame;
@property (nonatomic, assign) CGRect retweetedImageFrame;
@property (nonatomic, strong) XSMStatus *status;

/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
