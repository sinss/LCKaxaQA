//
//  questionInfo.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "questionInfo.h"


@implementation questionInfo
@synthesize classGroup;
@synthesize seq,type,title,content,imageUrl,status,package,answer,education,course;
@synthesize imageName, imageFilePath, smallImageName;
@synthesize answerName, date, degree, discussid, subject, theme;

- (id)init
{
    if (self = [super init])
    {
        title = [NSString stringWithFormat:@""];
        content = [NSString stringWithFormat:@""];
        education = 0;
        course = 0;
    }
    return self;
}
- (void)dealloc
{
    [type release], type = nil;
    [title release], title = nil;
    [content release], content = nil;
    [imageUrl release], imageUrl = nil;
    [status release], status = nil;
    [package release], package = nil;
    [imageName release], imageName = nil;
    [smallImageName release], smallImageName = nil;
    [imageFilePath release], imageFilePath = nil;
    [answerName release], answerName = nil;
    [date release], date = nil;
    [degree release], degree = nil;
    [discussid release], discussid = nil;
    [theme release], theme = nil;
    [subject release], subject = nil;
    [super dealloc];
}
@end
