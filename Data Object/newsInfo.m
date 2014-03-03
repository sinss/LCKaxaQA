//
//  newsInfo.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/21.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "newsInfo.h"

@implementation newsInfo

@synthesize seq,title,content,date,url,imageUrl, click;

- (id)init
{
    self = [super init];
    if (self)
    {
        click = NO;
    }
    return self;
}
- (void)dealloc
{
    [title release], title = nil;
    [content release], content = nil;
    [date release], date = nil;
    [url release], url = nil;
    [imageUrl release], imageUrl = nil;
    [super dealloc];
}

@end
