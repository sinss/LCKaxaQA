//
//  AccountCheck.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/12.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "AccountCheck.h"

@interface AccountCheck()

- (BOOL)parseAccountXml:(NSData*)xmlData;

@end

@implementation AccountCheck

@synthesize delegate;
- (id)initWithType:(accountCheckType)accountType
{
    if (self = [super init])
    {
        currentType = accountType;
    }
    return self;
}
- (id)init
{
    if (self = [super init])
    {
        if (myPoster == nil)
            myPoster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeLogin];
    }
    return self;
}
- (void)dealloc
{
    [info release], info = nil;
    [super dealloc];
}

#pragma mark - MyPostDelegate
- (void)MyPostDelegate:(MyPostDelegate *)poster didFinishPost:(NSArray *)result
{
    if ([self parseAccountXml:[result objectAtIndex:0]])
        [delegate didSucceedWithAccountCheck];
    else
        [delegate didFaildWithAccountCheck];
    myPoster = nil;
}
- (void)MyPostDelegate:(MyPostDelegate *)poster didFailParseXmlWithError:(NSError *)error
{
    NSLog(@"accountCheck:%@",error);
    [delegate didFaildWithAccountCheck];
    myPoster = nil;
}
- (void)MyPostDelegate:(MyPostDelegate *)poster didFailWithError:(NSError *)error
{
    NSLog(@"accountCheck:%@",error);
    [delegate didFaildWithAccountCheck];
    myPoster = nil;
}

#pragma mark - user define function
- (loginInfo*)checkAccountInfo
{
    NSString *accountInfoPath = [[GlobalFunctions shareInstance] getDocumentFullPath:accountInfoName];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:accountInfoPath];
    loginInfo *checkInfo = [[loginInfo alloc] init];
    //NSString *accountInfoPath = [[NSBundle mainBundle] pathForResource:@"logincheck" ofType:@"xml"];
    //NSData *xmlData = [[NSData alloc] initWithContentsOfFile:accountInfoPath];
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    NSLog(@"xmlDoc:%@",[[xmlDoc rootElement] stringValue]);
    if (xmlDoc == nil)
    {
        NSLog(@"accountInfo.plist not exist");
        checkInfo.status = 1;
        checkInfo.accountID = [NSString stringWithFormat:@""];
        checkInfo.password = [NSString stringWithFormat:@""];
    }
    else
    {
        NSArray *items = [xmlDoc nodesForXPath:loginXpath error:nil];
        GDataXMLElement *ele = [items objectAtIndex:0];
        checkInfo.email = [[ele childAtIndex:loginXpathOptionAccountId] stringValue];
        checkInfo.accountID = [[ele childAtIndex:loginXpathOptionMail] stringValue];
        checkInfo.accountName = [[ele childAtIndex:loginXpathOptionAccountname] stringValue];
        //checkInfo.password = [[ele childAtIndex:loginXpathOptionPassword] stringValue];
        //checkInfo.nickname = [[ele childAtIndex:loginXpathOptionNickname] stringValue];
        checkInfo.status = [[[ele childAtIndex:loginXpathOptionStatus] stringValue] integerValue];
        checkInfo.token = [[ele childAtIndex:loginXpathOptionToken] stringValue];
        checkInfo.accountLock = [[ele childAtIndex:loginXpathOptionAccountLock] stringValue];
    }
    return checkInfo;
}
- (void)startCheckWithAccount:(NSString *)account andPassword:(NSString *)pwd andDeviceToken:(NSString *)token
{
    myPoster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeLogin];
    
    //NSString *urlString = [NSString stringWithFormat:loginUrl,account,pwd];
    loginInfo *login = [[loginInfo alloc] init];
    login.accountID = account;
    login.password = pwd;
    login.token = token;
    //NSLog(@"token:%@",token);
    NSURL *url = [NSURL URLWithString:loginUrl2];
    [myPoster setDelegate:self];
    //[myPoster startPostWithUrl:url];
    [myPoster startloginWithUrl:url withAccound:login];
    [login release];
}
- (void)startSignupWithAccount:(loginInfo*)accountInfo;
{
    //[accountInfo retain];
    myPoster = [[MyPostDelegate alloc] initWithType:MyPostDelegateTypeSignup];
    NSString *urlString = [NSString stringWithFormat:signupUrl3];
    //NSString *urlString = [NSString stringWithFormat:signupUrl2];
    NSURL *url = [NSURL URLWithString:urlString];
    [myPoster setDelegate:self];
    //[myPoster startPostWithUrl:url];
    [myPoster startSignupWithUrl:url andAccountInfo:accountInfo];
}
- (BOOL)parseAccountXml:(NSData*)xmlData
{
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    if (xmlDoc == nil)
        return NO;
    NSString *accountXmlPath = [[GlobalFunctions shareInstance] getDocumentFullPath:accountInfoName];
    [xmlData writeToFile:accountXmlPath atomically:YES];
    NSArray *items = [xmlDoc nodesForXPath:loginXpath error:nil];
    NSInteger loginStatus = 1;
    if ([items count] > 0)
    {
        GDataXMLElement *ele = [items objectAtIndex:0];
        loginStatus = [[[ele childAtIndex:0] stringValue] integerValue];
    }
    if (loginStatus == 0)
    {
        //登入成功
        return YES;
    }
    return NO;
}
- (void)clearAccountXml
{
    NSString *accountXmlPath = [[GlobalFunctions shareInstance] getDocumentFullPath:accountInfoName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:accountXmlPath])
        [fileManager removeItemAtPath:accountXmlPath error:nil];
}
@end
