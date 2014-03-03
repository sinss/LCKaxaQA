//
//  questionDetail.h
//  KaxaQ&A
//
//  Created by sinss on 12/11/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define questionDetaillXpath @"//result//question"

@interface questionDetail : NSObject
{
    NSNumber *type;
    NSString *discussid;
    NSString *title;
    NSInteger subjectInd;
    NSInteger degreeInd;
    NSString *subject;
    NSString *degree;
    NSNumber *topic;
    NSString *askerid;
    NSString *asker;
    NSArray *imageArray;
    NSString *youtubeKey;
    NSString *content;
    NSString *date;
    NSNumber *status;
    NSString *imageFilePath;
}

@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSString *discussid;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *degree;
@property (nonatomic, retain) NSNumber *topic;
@property (assign) NSInteger subjectInd;
@property (assign) NSInteger degreeInd;
@property (nonatomic, retain) NSString *askerid;
@property (nonatomic, retain) NSString *asker;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) NSString *youtubeKey;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSNumber *status;

@property (nonatomic, retain) NSString *imageFilePath;

@end
