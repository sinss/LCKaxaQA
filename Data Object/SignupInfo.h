//
//  SignupInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignupInfo : NSObject
{
    NSString *accountID;
    NSString *password;
    NSString *userName;
    NSString *email;
}
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *email;

@end
