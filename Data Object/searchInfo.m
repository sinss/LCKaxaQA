//
//  searchInfo.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "searchInfo.h"

@implementation searchInfo
@synthesize discussID, theme, subject, degree, title, asker, date, status;

- (void)dealloc
{
    [discussID release], discussID = nil;
    [theme release], theme = nil;
    [subject release], subject = nil;
    [degree release], degree = nil;
    [title release], title = nil;
    [asker release], asker = nil;
    [date release], date = nil;
    [status release], status = nil;
    [super dealloc];
}

@end
