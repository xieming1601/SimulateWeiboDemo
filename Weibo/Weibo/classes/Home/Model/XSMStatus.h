//
//  XSMStatus.h
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class XSMUser;

@interface XSMStatus : NSObject

/**
 *  字符串类型的微博id
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  创建微博时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博user
 */
@property (nonatomic, strong) XSMUser *user;
/**
 *  缩略图地址
 */
@property (nonatomic, strong) XSMStatus *retweeted_status;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, strong) NSArray *pic_urls;


@end
