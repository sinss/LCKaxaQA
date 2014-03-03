//
//  newsInfo.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/3/21.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

#define newsXpath @"//result//news"
#define questionXpath @"//result//question"

enum
{
    newInfoXpathOptionSeq = 0,
    newInfoXpathOptionDate = 2,
    newInfoXpathOptionTitle = 3,
    newInfoXpathOptionContent = 4,
    newInfoXpathOptionUrl = 5,
    newInfoXpathOptionImageUrl = 6
};

@interface newsInfo : NSObject
{
    NSInteger seq;
    NSString *title;
    NSString *content;
    NSString *date;
    NSString *url;
    NSString *imageUrl;
    BOOL click;
}
@property (nonatomic, readwrite) NSInteger seq;
@property (nonatomic, readwrite, retain) NSString *title;
@property (nonatomic, readwrite, retain) NSString *content;
@property (nonatomic, readwrite, retain) NSString *date;
@property (nonatomic, readwrite, retain) NSString *url;
@property (nonatomic, readwrite, retain) NSString *imageUrl;
@property (nonatomic, readwrite) BOOL click;

@end
