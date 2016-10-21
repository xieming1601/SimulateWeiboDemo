//
//  XSMAcountTool.h
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSMAccount.h"

@interface XSMAcountTool : NSObject

+ (void)saveAccount:(XSMAccount *)account;
+ (XSMAccount *)account;

@end
