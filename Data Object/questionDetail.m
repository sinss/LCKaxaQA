//
//  questionDetail.m
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "questionDetail.h"

@implementation questionDetail
@synthesize status, discussid, title, subject, degree, topic, asker, imageArray, youtubeKey, content;
@synthesize date, type, askerid, imageFilePath, degreeInd, subjectInd;

- (void)dealloc
{
    [title release], title = nil;
    [subject release], subject = nil;
    [topic release], topic = nil;
    [type release], type = nil;
    [discussid release], discussid = nil;
    [degree release], degree = nil;
    [asker release], asker = nil;
    [imageArray release], imageArray = nil;
    [youtubeKey release], youtubeKey = nil;
    [content release], content = nil;
    [date release], date = nil;
    [status release], status = nil;
    [imageFilePath release], imageFilePath = nil;
    [super dealloc];
}

@end
