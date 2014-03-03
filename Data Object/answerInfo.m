//
//  answerInfo.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/5.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "answerInfo.h"

@implementation answerInfo
@synthesize seq, type, content, answerDate, status, imageUrl, imageName, smallImageName;

- (void)dealloc
{
    [type release], type = nil;
    [content release], content = nil;
    [answerDate release], answerDate = nil;
    [imageUrl release], imageUrl = nil;
    [imageName release], imageName = nil;
    [smallImageName release], smallImageName = nil;
    [super dealloc];
}

@end
