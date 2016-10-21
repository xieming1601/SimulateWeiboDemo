//
//  XSMAccount.h
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSMAccount : NSObject<NSCoding>

/** 用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;
/** access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSString *expires_in;
/** 当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
