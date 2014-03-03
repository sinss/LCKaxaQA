//
//  replyInfo.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "replyInfo.h"

@implementation replyInfo

@synthesize rid, qid;
@synthesize belongName;
@synthesize replyName;
@synthesize dateTime;
@synthesize imageUrl, imageName, smallImageName, imageFilePath;
@synthesize title,content, course, education;

- (void)dealloc
{
    [belongName release], belongName = nil;
    [replyName release], replyName = nil;
    [dateTime release], dateTime = nil;
    [imageUrl release], imageUrl = nil;
    [imageName release], imageName = nil;
    [smallImageName release], smallImageName = nil;
    [imageFilePath release], imageFilePath = nil;
    [title release], title = nil;
    [content release], content = nil;
    [super dealloc];
}

@end
