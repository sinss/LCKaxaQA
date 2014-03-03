//
//  newsInfo2.m
//  KaxaQ&A
//
//  Created by sinss on 12/9/29.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "newsInfo2.h"

@implementation newsInfo2
@synthesize newsId, releaseDate, title, content;

- (void)dealloc
{
    [newsId release], newsId = nil;
    [releaseDate release], releaseDate = nil;
    [title release], title = nil;
    [content release], content = nil;
    [super dealloc];
}

@end
