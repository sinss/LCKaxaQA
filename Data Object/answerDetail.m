//
//  answerDetail.m
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "answerDetail.h"

@implementation answerDetail
@synthesize seq, type, replier, replierid, replyid, imageArray, youtubeKey, content, date;

- (void)dealloc
{
    [seq release], seq = nil;
    [replierid release], replierid = nil;
    [replyid release], replyid = nil;
    [replier release], replierid = nil;
    [imageArray release], imageArray = nil;
    [content release], content = nil;
    [date release], date = nil;
    [youtubeKey release], youtubeKey = nil;
    [type release], type = nil;
    [super dealloc];
}

@end
