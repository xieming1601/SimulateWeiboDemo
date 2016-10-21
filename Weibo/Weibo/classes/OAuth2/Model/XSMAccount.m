//
//  XSMAccount.m
//  Weibo
//
//  Created by xsm on 2016/10/11.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "XSMAccount.h"

@implementation XSMAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    XSMAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    
    return account;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_access_token forKey:@"access_token"];
    [encoder encodeObject:_expires_in forKey:@"expires_in"];
    [encoder encodeObject:_uid forKey:@"uid"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}


@end
