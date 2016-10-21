//
//  XSMAcountTool.m
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

//保存账号的路径
#define VSAAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]


#import "XSMAcountTool.h"

@implementation XSMAcountTool

+ (void)saveAccount:(XSMAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:VSAAccountPath];
}

+ (XSMAccount *)account {
    XSMAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:VSAAccountPath];
    
    //暂时先考虑过期的问题
    return account;
}

@end
