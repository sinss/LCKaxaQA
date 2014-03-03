//
//  forgotPasswordInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface forgotPasswordInfo : NSObject
{
    NSString *accountID;
    NSString *email;
}
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *email;
@end
