//
//  uploadResult.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/29.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define uploadStatusXpath @"//result//status"

@interface uploadResult : NSObject
{
    NSInteger errorCode;
}
@property (nonatomic, assign) NSInteger errorCode;

@end
