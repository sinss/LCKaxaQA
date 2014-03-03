//
//  replyInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/4/7.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define myAreaReplyXpath @"//result//reply"

enum
{
    myAreaReplyXpathOptionRid = 0,
    myAreaReplyXpathOptionQid = 1,
    myAreaReplyXpathOptionBelongName = 2,
    myAreaReplyXpathOptionReplyName = 3,
    myAreaReplyXpathOptionImageUrl = 4,
    myAreaReplyXpathOptionTitle = 5,
    myAreaReplyXpathOptionCourse = 6,
    myAreaReplyXpathOptionEducation = 7,
    myAreaReplyXpathOptionDateTime = 8,
    myAreaReplyXpathOptionContent = 9,
};
typedef NSInteger myAreaReplyXpathOption;


@interface replyInfo : NSObject
{
    //問題序號
    NSInteger rid;
    NSInteger qid;
    NSString *belongName;
    NSString *replyName;
    NSString *dateTime;
    //照片連結
    NSString *imageUrl;
    NSString *title;
    NSString *content;
    NSInteger course;
    NSInteger education;
    NSString *imageName;
    NSString *smallImageName;
    NSString *imageFilePath;
}
@property (nonatomic, readwrite) NSInteger rid;
@property (nonatomic, readwrite) NSInteger qid;
@property (nonatomic, readwrite, retain) NSString *belongName;
@property (nonatomic, readwrite, retain) NSString *replyName;
@property (nonatomic, readwrite, retain) NSString *dateTime;
@property (nonatomic, readwrite, retain) NSString *imageUrl;
@property (nonatomic, readwrite, retain) NSString *title;
@property (nonatomic, readwrite, retain) NSString *content;
@property (nonatomic, readwrite) NSInteger course;
@property (nonatomic, readwrite) NSInteger education;
@property (nonatomic, readwrite, retain) NSString *imageName;
@property (nonatomic, readwrite, retain) NSString *smallImageName;
@property (nonatomic, readwrite, retain) NSString *imageFilePath;
@end