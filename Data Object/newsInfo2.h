//
//  newsInfo2.h
//  KaxaQ&A
//
//  Created by sinss on 12/9/29.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    newInfo2XpathOptionId = 0,
    newInfo2XpathOptionReleasedate = 1,
    newInfo2XpathOptionTitle = 2,
    newInfo2XpathOptionDescription = 3,
};

@interface newsInfo2 : NSObject
{
    NSString *newsId;
    NSString *releaseDate;
    NSString *title;
    NSString *content;
}
@property (nonatomic, retain) NSString *newsId;
@property (nonatomic, retain) NSString *releaseDate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;

@end
