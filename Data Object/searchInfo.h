//
//  searchInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define searchQuestionXpath @"//result//search"

enum
{
    searchXpathOptionDiscussID = 0,
    searchXpathOptionTheme = 1,
    searchXpathOptionSubject = 2,
    searchXpathOptionDegree = 3,
    searchXpathOptionTitle = 4,
    searchXpathOptionAsker = 5,
    searchXpathOptionDate = 6,
    searchXpathOptionStatus = 7,
};

@interface searchInfo : NSObject
{
    NSString *discussID;
    NSString *theme;
    NSString *subject;
    NSString *degree;
    NSString *title;
    NSString *asker;
    NSString *date;
    NSNumber *type;
}
@property (nonatomic, retain) NSString *discussID;
@property (nonatomic, retain) NSString *theme;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *degree;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *asker;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSNumber *status;

@end
