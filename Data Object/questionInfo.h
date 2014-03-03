//
//  questionInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define coderSeqKey @"seq"
#define coderTypeKey @"type"
#define coderTitleKey @"title"
#define coderContentKey @"content"
#define coderImageurlKey @"imageUrl"
#define coderStatusKey @"status"
#define coderPackageKey @"package"
#define coderAnswerKey @"answer"

#define meQustionXpath @"result//question"
#define meReplyXpath @"result//reply"
#define meSubscribeXpath @"result//Subscribe"
#define meAnswerXpath @"result//question2"

/*
enum
{
    myAreaQuestionXpathOptionSeq = 0,
    myAreaQuestionXpathOptionType = 1,
    myAreaQuestionXpathOptionTitle = 2,
    myAreaQuestionXpathOptionContent = 3,
    myAreaQuestionXpathOptionImageUrl = 4,
    myAreaQuestionXpathOptionStatus = 5,
    myAreaQuestionXpathOptionPackage = 6,
    myAreaQuestionXpathOptionAnswer = 7,
    myAreaQuestionXpathOptionEducation = 8,
    myAreaQuestionXpathOptionCourse = 9,
    myAreaQuestionXpathOptionImageName = 10
};
 */
enum
{
    meXpathOptionDiscussid = 0,
    meXpathOptionTheme = 1,
    meXpathOptionSubject = 2,
    meXpathOptionDegree = 3,
    meXpathOptionTitle = 4,
    meXpathOptionAsker = 5,
    meXpathOptionDate = 6,
};

enum
{
    meXpathReplyDiscussid = 1,
    meXpathReplyTheme = 2,
    meXpathReplySubject = 3,
    meXpathReplyDegree = 4,
    meXpathReplyTitle = 5,
    meXpathReplyAsker = 6,
    meXpathReplyDate = 7,
};

@interface questionInfo : NSObject
{
    //問題序號
    NSString *discussid;
    NSString *theme;
    NSInteger seq;
    //0:已問過的問題 1:已回答過問題
    NSString *type;
    NSString *title;
    NSString *content;
    //照片連結
    NSString *imageUrl;
    //0:未結案 1:已結案
    NSString *status;
    //0:已封存 1:未封存
    NSString *package;
    //回答數量
    NSInteger answer;
    NSString *answerName;
    NSInteger education;
    NSInteger course;
    NSString *subject;
    NSString *degree;
    NSString *imageName;
    NSString *smallImageName;
    NSString *imageFilePath;
    NSString *classGroup;
    NSString *date;
}
@property (nonatomic, retain) NSString *discussid;
@property (nonatomic, retain) NSString *theme;
@property (nonatomic, readwrite) NSInteger seq;
@property (nonatomic, readwrite, retain) NSString *type;
@property (nonatomic, readwrite, retain) NSString *title;
@property (nonatomic, readwrite, retain) NSString *content;
@property (nonatomic, readwrite, retain) NSString *imageUrl;
@property (nonatomic, readwrite, retain) NSString *status;
@property (nonatomic, readwrite, retain) NSString *package;
@property (nonatomic, retain) NSString *answerName;
@property (nonatomic, readwrite) NSInteger answer;
@property (nonatomic, readwrite) NSInteger education;
@property (nonatomic, readwrite) NSInteger course;
@property (nonatomic, readwrite, retain) NSString *subject;
@property (nonatomic, readwrite, retain) NSString *degree;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *smallImageName;
@property (nonatomic, retain) NSString *imageFilePath;
@property (nonatomic, retain) NSString *classGroup;
@property (nonatomic, retain) NSString *date;


@end
