//
//  XSMUser.h
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSMUser : NSObject

/**
 *  user idstr
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  user name
 */
@property (nonatomic, copy) NSString *name;
/**
 *  是否为加V用户
 */
@property (nonatomic, assign) BOOL verified;
/**
 *  认证原因
 */
@property (nonatomic, copy) NSString *verified_reason;
/**
 *  user profile_image_url
 */
@property (nonatomic, copy) NSString *profile_image_url;

@end
