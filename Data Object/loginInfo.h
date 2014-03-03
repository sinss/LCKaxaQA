//
//  loginInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define loginStatusXpath @"//result//status"
#define loginAccountnameXpath @"//result//accountname"
#define loginEmailXpath @"result//mail"
#define loginXpath @"//result"

enum
{
    loginXpathOptionStatus = 0,
    loginXpathOptionAccountId = 1,
    loginXpathOptionAccountname = 2,
    loginXpathOptionMail = 3,
    loginXpathOptionAccountLock = 4,
    loginXpathOptionToken = 5
};
typedef NSInteger loginXpathOption;

@interface loginInfo : NSObject
{
    NSInteger status;
    NSString *accountID;
    NSString *password;
    NSString *rePassword;
    NSString *accountName;
    NSString *email;
    NSString *nickname;
    NSInteger mid;
    NSString *token;
    NSString *accountLock;
}
@property (nonatomic, readwrite) NSInteger status;
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *rePassword;
@property (nonatomic, retain) NSString *accountName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *accountLock;

- (id)initWithFaild;

@end
