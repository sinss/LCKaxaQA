//
//  GlobalFunctions.h
//  ClockReminder
//
//  Created by 張星星 on 11/12/16.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalFunctions : NSObject

+(GlobalFunctions*)shareInstance;

- (NSString*)getDocumentFullPath:(NSString*)fileName;
- (NSString*)getTempDirectoryFullPath:(NSString*)fileName;
- (NSInteger)currentLanguageInd;
- (void)saveAppInfoWithKey:(NSString*)key andValue:(NSString*)value;
- (NSString*)getAppInfoWithKey:(NSString*)key;

- (NSString*)getEducationString:(NSInteger)eduInd;
- (NSString*)getCourseString:(NSInteger)courseInd;
- (NSString*)getPackageString:(NSString*)package;
- (NSString*)getQuestionStatus:(NSString*)status;
- (NSString*)getTopicNameWithIndex:(NSInteger)topicInd;
- (NSString*)base64forData:(NSData*)theData;
- (BOOL)checkIsValidEmail:(NSString *)checkString;

@end
