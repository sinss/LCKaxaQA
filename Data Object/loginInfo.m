//
//  loginInfo.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "loginInfo.h"

@implementation loginInfo

@synthesize status;
@synthesize accountID;
@synthesize password;
@synthesize rePassword;
@synthesize accountName;
@synthesize email;
@synthesize nickname;
@synthesize mid;
@synthesize token;
@synthesize accountLock;

- (id)initWithFaild
{
    if (self = [super init])
    {
        status = 1;  //faild
        accountID = [[NSString alloc] initWithFormat:@""];
        password = [[NSString alloc] initWithFormat:@""];
        nickname = [[NSString alloc] initWithFormat:@""];
        accountLock = [[NSString alloc] initWithFormat:@""];
    }
    return self;
}
- (void)dealloc
{
    [accountID release], accountID = nil;
    [password release], password = nil;
    [rePassword release], rePassword = nil;
    [accountName release], accountName = nil;
    [email release], email = nil;
    [nickname release], nickname = nil;
    [token release], token = nil;
    [accountLock release], accountLock = nil;
    [super dealloc];
}
@end
