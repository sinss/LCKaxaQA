//
//  newsDetail.h
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define newsDetailIdXpath @"//result//news"


@interface newsDetail : NSObject
{
    NSString *newsId;
    NSString *releaseDate;
    NSString *title;
    NSString *content;
}
@property (nonatomic, retain) NSString *newsId;
@property (nonatomic, retain) NSString *releaseDate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;

@end
