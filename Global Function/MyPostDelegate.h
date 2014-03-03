//
//  MyPostDelegate.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "questionInfo.h"
#import "replyInfo.h"
#import "searchInfo.h"
#import "answerInfo.h"
#import "newsInfo.h"
#import "newsInfo2.h"
#import "loginInfo.h"
#import "uploadResult.h"
#import "ASIFormDataRequest.h"
#import "questionDetail.h"
#import "answerDetail.h"
#import "newsDetail.h"
/*
 type:
 0:home
 1:MyArea
 2:Search
 3:detail
 4:login
 5:signup
 6:forgot password
 */

enum
{
    MyPostDelegateTypeHome = 0,
    MyPostDelegateTypeMyArea = 1,
    MyPostDelegateTypeSearch = 2,
    MyPostDelegateTypeDetail = 3,
    MyPostDelegateTypeLogin = 4,
    MyPostDelegateTypeSignup = 5,
    MyPostDelegateTypeForgotPassword = 6,
    MyPostDelegateTypeAskQuestion = 7,
    MyPostDelegateTypeReplyQuestion = 8,
    MyPostDelegateTypeNewsDetail = 9,
};
typedef NSInteger MyPostDelegateType;

@class MyPostDelegate;
@protocol postDelegate <NSObject>

- (void)MyPostDelegate:(MyPostDelegate*)poster didFinishPost:(NSArray*)result;
- (void)MyPostDelegate:(MyPostDelegate*)poster didFailWithError:(NSError *)error;
- (void)MyPostDelegate:(MyPostDelegate *)poster didFailParseXmlWithError:(NSError *)error;


@end

@interface MyPostDelegate : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *responseData;
    NSArray *resultList;
    NSURLConnection *connection;
    id<postDelegate> delegate;
    NSInteger type;
    ASIFormDataRequest *ASIrequest;
}

@property (assign) id<postDelegate> delegate;

- (id)initWithType:(MyPostDelegateType)typeInd;
- (void)startPostWithUrl:(NSURL*)url;
- (void)startPostWithUrl:(NSURL*)url withData:(NSMutableData*)body;
- (void)startUploadFileWithCreateQuestion:(NSURL*)url withNewInfo:(questionDetail*)info andAccount:(loginInfo*)accountInfo;
- (void)startUploadFileWithReplyQuestion:(NSURL*)url withAnswerInfo:(questionDetail*)info AndAccount:(loginInfo*)accountInfo;
- (void)startloginWithUrl:(NSURL*) url withAccound:(loginInfo*)accountInfo;
- (void)startSignupWithUrl:(NSURL*)url andAccountInfo:(loginInfo*)accountInfo;
- (void)startSearchWithUrl:(NSURL*)url andSearchKey:(NSString*)keyword andEducation:(NSInteger)edu andCource:(NSInteger)cource;
- (void)startGetMyAreaQuestionWithUrl:(NSURL*)url andAccound:(NSString*)account;
- (void)startGetQuestionDetailWithUrl:(NSURL*)url andDiscussid:(NSString*)discussid;
- (void)startGetNewDetailWithUrl:(NSURL*)url andNewsId:(NSString*)newsid;
- (void)cancelPost;
- (void)cancelAsiPost;
@end
