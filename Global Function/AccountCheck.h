//
//  AccountCheck.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/12.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPostDelegate.h"
#import "loginInfo.h"
#import "GlobalFunctions.h"
#import "GDataXMLNode.h"

enum
{
    accountCheckTypeLogin = 0,
    accountCheckTypeSignup = 1
};
typedef NSInteger accountCheckType;

@class AccountCheck;
@protocol AccountCheckDelegate <NSObject>

- (void)didSucceedWithAccountCheck;
- (void)didFaildWithAccountCheck;

@end

@interface AccountCheck : NSObject <postDelegate>
{
    accountCheckType currentType;
    MyPostDelegate *myPoster;
    loginInfo *info;
    id<AccountCheckDelegate> delegate;
}
@property (assign) id<AccountCheckDelegate> delegate;

- (id)initWithType:(accountCheckType)accountType;
- (void)startCheckWithAccount:(NSString*)account andPassword:(NSString*)pwd andDeviceToken:(NSString*)token;
- (void)startSignupWithAccount:(loginInfo*)accountInfo;
- (void)clearAccountXml;
- (loginInfo*)checkAccountInfo;
@end
