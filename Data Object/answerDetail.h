//
//  answerDetail.h
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define answerDetailXpath @"//result//answer"

@interface answerDetail : NSObject
{
    NSNumber *seq;
    NSNumber *type;
    NSString *replyid;
    NSString *replierid;
    NSString *replier;
    NSArray *imageArray;
    NSString *youtubeKey;
    NSString *content;
    NSString *date;
}
@property (nonatomic, retain) NSNumber *seq;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSString *replyid;
@property (nonatomic, retain) NSString *replierid;
@property (nonatomic, retain) NSString *replier;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) NSString *youtubeKey;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *date;

@end
