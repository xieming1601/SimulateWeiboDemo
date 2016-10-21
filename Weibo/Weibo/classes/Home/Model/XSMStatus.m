//
//  XSMStatus.m
//  Weibo
//
//  Created by xsm on 2016/10/13.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMStatus.h"
#import "XSMPhoto.h"

@implementation XSMStatus

+ (NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [XSMPhoto class]};
}

@end
