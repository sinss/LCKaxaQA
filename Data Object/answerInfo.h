//
//  answerInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/5.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define answerXpath @"//result//answer"

enum
{
    answerXpathOptionSeq = 0,
    answerXpathOptionType = 1,
    answerXpathOptionContent = 2,
    answerXpathOptionImageUrl = 3,
    answerXpathOptionDate = 4,
    answerXpathOptionStatus = 5,
    answerXpathOptionImageName = 6
};
typedef NSInteger answerXpathOption;

@interface answerInfo : NSObject
{
    NSInteger seq;
    NSString *type;
    NSString *content;
    NSString *answerDate;
    NSInteger status;
    NSString *imageUrl;
    NSString *imageName;
    NSString *smallImageName;
}
@property (nonatomic, readwrite) NSInteger seq;
@property (nonatomic, readwrite, retain) NSString *type;
@property (nonatomic, readwrite, retain) NSString *content;
@property (nonatomic, readwrite, retain) NSString *answerDate;
@property (nonatomic, readwrite) NSInteger status;
@property (nonatomic, readwrite, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *smallImageName;

@end
