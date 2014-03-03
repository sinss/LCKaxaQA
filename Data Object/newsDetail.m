//
//  newsDetail.m
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "newsDetail.h"

@implementation newsDetail
@synthesize newsId, content, releaseDate, title;

- (void)dealloc
{
    [newsId release], newsId = nil;
    [content release], content = nil;
    [releaseDate release], [releaseDate release];
    [title release], title = nil;
    [super dealloc];
}

@end
