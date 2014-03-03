//
//  MyPostDelegate.m
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "MyPostDelegate.h"

@interface MyPostDelegate()

- (BOOL)parseXml;
- (void)asiFaild:(ASIHTTPRequest*)request;
- (void)asiFinished:(ASIHTTPRequest*)request;

@end

@implementation MyPostDelegate

@synthesize delegate;

- (id)initWithType:(MyPostDelegateType)typeInd
{
    if (self = [super init])
    {
        type = typeInd;
    }
    return self;
}
- (void)startPostWithUrl:(NSURL*)url
{
    /*
     type:
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
     */
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:120];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    NSLog(@"postUrl:%@",url);
    if (connection)
    {
        responseData = [NSMutableData new];
    }
}
- (void)startPostWithUrl:(NSURL*)url withData:(NSMutableData*)body
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%d",[body length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:body];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection)
    {
        responseData = [NSMutableData new];
    }
}

- (void)startUploadFileWithCreateQuestion:(NSURL*)url withNewInfo:(questionDetail*)info andAccount:(loginInfo*)accountInfo
{
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    /*
    [ASIrequest setPostValue:accountInfo.accountID forKey:@"acc"];
    [ASIrequest setPostValue:accountInfo.password forKey:@"pass"];
    [ASIrequest setPostValue:@"q" forKey:@"act"];
    [ASIrequest setPostValue:info.title forKey:@"q_title"];
    [ASIrequest setPostValue:info.content forKey:@"content"];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",info.course] forKey:@"u_course"];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",info.education] forKey:@"u_education"];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",accountInfo.mid] forKey:@"mid"];
    if (info.imageFilePath != nil)
        [ASIrequest setFile:info.imageFilePath forKey:@"image"];    
     */
    [ASIrequest setPostValue:accountInfo.accountID forKey:@"AccID"];
    switch ([info.topic integerValue])
    {
        case 0:
            //全部    全部
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",1] forKey:@"tid"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",0] forKey:@"sj"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",1] forKey:@"dg"];
            break;
        case 1:
            //數學 ， 全部
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",1] forKey:@"tid"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",3] forKey:@"sj"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",1] forKey:@"dg"];
            break;
        case 2:
            //物理 ， 高中
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",2] forKey:@"tid"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",4] forKey:@"sj"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",4] forKey:@"dg"];
            break;
        case 3:
            //化學 ， 高中
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",3] forKey:@"tid"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",5] forKey:@"sj"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",4] forKey:@"dg"];
            break;
        case 4:
            //理化 ， 國中
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",4] forKey:@"tid"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",6] forKey:@"sj"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",3] forKey:@"dg"];
            break;
        case 5:
            //相片筆記 (地科) 、 全部
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",5] forKey:@"tid"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",7] forKey:@"sj"];
            [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",1] forKey:@"dg"];
            break;
    }
    //[ASIrequest setPostValue:[NSString stringWithFormat:@"%i",info.subjectInd] forKey:@"sj"];
    //[ASIrequest setPostValue:[NSString stringWithFormat:@"%i",info.degreeInd] forKey:@"dg"];
    [ASIrequest setPostValue:info.title forKey:@"title"];
    [ASIrequest setPostValue:@"" forKey:@"answerid"];
    [ASIrequest setPostValue:info.content forKey:@"content"];
    if (info.imageFilePath != nil)
        [ASIrequest setFile:info.imageFilePath forKey:@"image"];

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];

    [ASIrequest startAsynchronous];
}

- (void)startUploadFileWithReplyQuestion:(NSURL*)url withAnswerInfo:(questionDetail*)info AndAccount:(loginInfo*)accountInfo
{
    //http://www.kaxa.com.tw/phone/phone_reply.php?AccID=20121009M000001&disid=20121011P000001&tid=1&sj=3&dg=2&content=Test
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    [ASIrequest setPostValue:accountInfo.accountID forKey:@"AccID"];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"%@",info.discussid] forKey:@"disid"];
    [ASIrequest setPostValue:info.title forKey:@"content"];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",info.subjectInd] forKey:@"sj"];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"%i",info.degreeInd] forKey:@"dg"];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"1"] forKey:@"tid"];
    if (info.imageFilePath != nil)
        [ASIrequest setFile:info.imageFilePath forKey:@"image"];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];
    
    [ASIrequest startAsynchronous];
}

- (void)startloginWithUrl:(NSURL*) url withAccound:(loginInfo*)accountInfo;
{
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:accountInfo.accountID forKey:@"acc"];
    //[request setPostValue:accountInfo.password forKey:@"pass"];
    NSString *accountID = [[NSString alloc] initWithFormat:@"%@",accountInfo.accountID];
    NSString *password = [[NSString alloc] initWithFormat:@"%@",accountInfo.password];
    NSString *token = [[NSString alloc] initWithFormat:@"%@",accountInfo.token];
    [ASIrequest setPostValue:accountID forKey:accountPostKey];
    [ASIrequest setPostValue:password forKey:passwordPostKey];
    [ASIrequest setPostValue:token forKey:tokenPostKey];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"iOS"] forKey:@"pty"];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];
    
    [ASIrequest startAsynchronous];
    [accountID release];
    [password release];
    [token release];
}
- (void)startSignupWithUrl:(NSURL *)url andAccountInfo:(loginInfo *)accountInfo
{
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    /*
    NSString *accountID = [[NSString alloc] initWithFormat:@"%@",accountInfo.accountID];
    NSString *password = [[NSString alloc] initWithFormat:@"%@",accountInfo.password];
    NSString *name = [[NSString alloc] initWithFormat:@"%@",accountInfo.accountName];
    NSString *email = [[NSString alloc] initWithFormat:@"%@",accountInfo.email];
    NSString *token = [[NSString alloc] initWithFormat:@"%@",accountInfo.token];
     */
    [ASIrequest setPostValue:accountInfo.accountID forKey:accountPostKey];
    [ASIrequest setPostValue:accountInfo.password forKey:passwordPostKey];
    [ASIrequest setPostValue:accountInfo.accountName forKey:namePostKey];
    [ASIrequest setPostValue:accountInfo.nickname forKey:nicknameKey];
    [ASIrequest setPostValue:accountInfo.token forKey:tokenPostKey];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"2000-01-01"] forKey:birthdayKey];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"0900123456"] forKey:phoneNumberKey];
    [ASIrequest setPostValue:[NSString stringWithFormat:@"0"] forKey:phoneType];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];
    
    [ASIrequest startAsynchronous];
}

- (void)startSearchWithUrl:(NSURL*)url andSearchKey:(NSString*)keyword andEducation:(NSInteger)edu andCource:(NSInteger)cource
{
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    
    [ASIrequest setPostValue:keyword forKey:@"kw"];
    [ASIrequest setPostValue:[NSNumber numberWithInteger:edu] forKey:@"dg"];
    [ASIrequest setPostValue:[NSNumber numberWithInteger:cource] forKey:@"sub"];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];
    
    [ASIrequest startAsynchronous];

}

- (void)startGetMyAreaQuestionWithUrl:(NSURL*)url andAccound:(NSString*)account
{
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    
    [ASIrequest setPostValue:account forKey:@"uid"];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];
    
    [ASIrequest startAsynchronous];
}

- (void)startGetQuestionDetailWithUrl:(NSURL*)url andDiscussid:(NSString*)discussid
{
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    
    [ASIrequest setPostValue:discussid forKey:@"qid"];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];
    
    [ASIrequest startAsynchronous];
}

- (void)startGetNewDetailWithUrl:(NSURL*)url andNewsId:(NSString*)newsid
{
    ASIrequest = [ASIFormDataRequest requestWithURL:url];
    
    [ASIrequest setPostValue:newsid forKey:@"nid"];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[ASIrequest setShouldContinueWhenAppEntersBackground:YES];
#endif
	[ASIrequest setDelegate:self];
	[ASIrequest setDidFailSelector:@selector(asiFaild:)];
	[ASIrequest setDidFinishSelector:@selector(asiFinished:)];
    
    [ASIrequest startAsynchronous];
}

- (BOOL)parseXml
{
    GDataXMLDocument *xmlDoc;
    if (type == MyPostDelegateTypeHome)
    {
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        if (xmlDoc == nil)
            return NO;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *newsArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *replyArray = [NSMutableArray arrayWithCapacity:0];
        NSArray *items = [xmlDoc nodesForXPath:newsXpath error:nil];
        NSLog(@"news count:%i",[items count]);
        for (GDataXMLElement *ele in items)
        {
            newsInfo2 *info = [[newsInfo2 alloc] init];
            info.newsId = [[ele childAtIndex:newInfo2XpathOptionId] stringValue];
            info.releaseDate = [[ele childAtIndex:newInfo2XpathOptionReleasedate] stringValue];
            info.title = [[ele childAtIndex:newInfo2XpathOptionTitle] stringValue];
            info.content = [[ele childAtIndex:newInfo2XpathOptionDescription] stringValue];
            NSRange range = [info.title rangeOfString:@"Android"];
            if (range.location == NSNotFound)
            {
                [newsArray addObject:info];
            }
            NSLog(@"new:%@",info);
            [info release];
        }
        /*
        items = [xmlDoc nodesForXPath:myAreaReplyXpath error:nil];
        for (GDataXMLElement *ele in items)
        {
            NSLog(@"id:%@",[[ele childAtIndex:0] stringValue]);
            //NSLog(@"%@",[[ele childAtIndex:1] stringValue]);
            NSLog(@"edu:%@",[[ele childAtIndex:myAreaReplyXpathOptionEducation] stringValue]);
            NSLog(@"course:%@",[[ele childAtIndex:myAreaReplyXpathOptionCourse] stringValue]);
            GDataXMLElement *node = (GDataXMLElement*)[ele childAtIndex:myAreaReplyXpathOptionImageUrl];
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@/%@id=%@&act=%@&type=%@",getImageUrl,
                                   [node stringValue],
                                   [[node attributeForName:@"id"] stringValue],
                                   [[node attributeForName:@"act"] stringValue],
                                   [[node attributeForName:@"type"] stringValue]];
            NSString *imageName = [[NSString alloc] initWithFormat:@"%@%@%@",
                                   [[node attributeForName:@"id"] stringValue],
                                   [[node attributeForName:@"act"] stringValue],
                                   [[node attributeForName:@"type"] stringValue]];
            NSString *smallImageName = [[NSString alloc] initWithFormat:@"%@s",imageName];
            replyInfo *info = [[replyInfo alloc] init];
            info.rid = [[[ele childAtIndex:myAreaReplyXpathOptionRid] stringValue] integerValue];
            info.qid = [[[ele childAtIndex:myAreaReplyXpathOptionQid] stringValue] integerValue];
            info.belongName = [[ele childAtIndex:myAreaReplyXpathOptionBelongName] stringValue];
            info.replyName = [[ele childAtIndex:myAreaReplyXpathOptionReplyName] stringValue];
            info.title = [[ele childAtIndex:myAreaReplyXpathOptionTitle] stringValue];
            info.imageUrl = urlString;
            info.education = [[[ele childAtIndex:myAreaReplyXpathOptionEducation] stringValue] integerValue];
            info.course = [[[ele childAtIndex:myAreaReplyXpathOptionCourse] stringValue] integerValue];
            info.imageName = imageName;
            info.smallImageName = smallImageName;
            info.dateTime = [[ele childAtIndex:myAreaReplyXpathOptionDateTime] stringValue];
            info.content = [[ele childAtIndex:myAreaReplyXpathOptionContent] stringValue];
            [replyArray addObject:info];
            [info release];
            [urlString release];
            [imageName release];
            [smallImageName release];
        }
         */
        [array addObject:newsArray];
        [array addObject:replyArray];
        resultList = [[NSArray alloc] initWithArray:array];
    }
    else if (type == MyPostDelegateTypeMyArea)
    {
        //MyArea
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        /*
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"questionList" ofType:@"xml"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath options:NSDataReadingMapped error:nil];
        xmlDoc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        */
        NSLog(@"xmlDoc:%@",[[xmlDoc rootElement] stringValue]);
        if (xmlDoc == nil)
            return NO;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *questionArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *subscribeArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *replyArray = [NSMutableArray arrayWithCapacity:0];
        NSArray *items = [xmlDoc nodesForXPath:meQustionXpath error:nil];
        NSLog(@"items count question:%i",[items count]);
        for (GDataXMLElement *ele in items)
        {
            questionInfo *question = [[questionInfo alloc] init];
            question.discussid = [[ele childAtIndex:meXpathOptionDiscussid] stringValue];
            question.theme = [[ele childAtIndex:meXpathOptionTheme] stringValue];
            question.subject = [[ele childAtIndex:meXpathOptionSubject] stringValue];
            question.degree = [[ele childAtIndex:meXpathOptionDegree] stringValue];
            question.title = [[ele childAtIndex:meXpathOptionTitle] stringValue];
            question.answerName = [[ele childAtIndex:meXpathOptionAsker] stringValue];
            question.date = [[ele childAtIndex:meXpathOptionDate] stringValue];
            [questionArray addObject:question];
            [question release];
        }
        items = [xmlDoc nodesForXPath:meReplyXpath error:nil];
        NSLog(@"items count answer:%i",[items count]);
        for (GDataXMLElement *ele in items)
        {
            questionInfo *question = [[questionInfo alloc] init];
            question.discussid = [[ele childAtIndex:meXpathReplyDiscussid] stringValue];
            question.theme = [[ele childAtIndex:meXpathReplyTheme] stringValue];
            question.subject = [[ele childAtIndex:meXpathReplySubject] stringValue];
            question.degree = [[ele childAtIndex:meXpathReplyDegree] stringValue];
            question.title = [[ele childAtIndex:meXpathReplyTitle] stringValue];
            question.answerName = [[ele childAtIndex:meXpathReplyAsker] stringValue];
            question.date = [[ele childAtIndex:meXpathReplyDate] stringValue];
            [subscribeArray addObject:question];
            [question release];
        }
        items = [xmlDoc nodesForXPath:meSubscribeXpath error:nil];
        NSLog(@"items count:%i",[items count]);
        for (GDataXMLElement *ele in items)
        {
            questionInfo *question = [[questionInfo alloc] init];
            question.discussid = [[ele childAtIndex:meXpathOptionDiscussid] stringValue];
            question.theme = [[ele childAtIndex:meXpathOptionTheme] stringValue];
            question.subject = [[ele childAtIndex:meXpathOptionSubject] stringValue];
            question.degree = [[ele childAtIndex:meXpathOptionDegree] stringValue];
            question.title = [[ele childAtIndex:meXpathOptionTitle] stringValue];
            question.answerName = [[ele childAtIndex:meXpathOptionAsker] stringValue];
            question.date = [[ele childAtIndex:meXpathOptionDate] stringValue];
            [replyArray addObject:question];
            [question release];
        }
        [array addObject:questionArray];
        [array addObject:replyArray];
        [array addObject:subscribeArray];
        resultList = [[NSArray alloc] initWithArray:array];;
    }
    else if (type == MyPostDelegateTypeSearch)
    {
        //search
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        if (xmlDoc == nil)
            return NO;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSArray *items = [xmlDoc nodesForXPath:searchQuestionXpath error:nil];
        NSLog(@"search count:%i",[items count]);
        for (GDataXMLElement *ele in items)
        {
            NSLog(@"id:%@",[[ele childAtIndex:0] stringValue]);
            //NSLog(@"%@",[[ele childAtIndex:1] stringValue]);
            searchInfo *info = [[searchInfo alloc] init];
            info.discussID = [[ele childAtIndex:searchXpathOptionDiscussID] stringValue];
            info.theme = [[ele childAtIndex:searchXpathOptionTheme] stringValue];
            info.subject = [[ele childAtIndex:searchXpathOptionSubject] stringValue];
            info.degree = [[ele childAtIndex:searchXpathOptionDegree] stringValue];
            info.title = [[ele childAtIndex:searchXpathOptionTitle] stringValue];
            info.asker = [[ele childAtIndex:searchXpathOptionAsker] stringValue];
            info.date = [[ele childAtIndex:searchXpathOptionDate] stringValue];
            info.status = [NSNumber numberWithInteger:[[[ele childAtIndex:searchXpathOptionStatus] stringValue] integerValue]];
            [array addObject:info];
            [info release];
        }
        resultList = [[NSArray alloc] initWithArray:array];
    }
    else if (type == MyPostDelegateTypeDetail)
    {
        //detailList
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        if (xmlDoc == nil)
            return NO;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSArray *items = [xmlDoc nodesForXPath:questionDetaillXpath error:nil];
        for (GDataXMLElement *ele in items)
        {
            NSLog(@"id:%@",[[ele childAtIndex:0] stringValue]);
            NSString *tmpString = [[ele childAtIndex:0] stringValue];
            NSString *imageString = [[ele childAtIndex:7] stringValue];
            NSArray *imageArray = [imageString componentsSeparatedByString:@","];
            if ([tmpString isEqualToString:@"0"])
            {
                questionDetail *detail = [[questionDetail alloc] init];
                detail.type = [NSNumber numberWithInteger:[tmpString integerValue]];
                detail.discussid = [[ele childAtIndex:1] stringValue];
                detail.title = [[ele childAtIndex:2] stringValue];
                detail.subject = [[ele childAtIndex:3] stringValue];
                detail.degree = [[ele childAtIndex:4] stringValue];
                detail.askerid = [[ele childAtIndex:5] stringValue];
                detail.asker = [[ele childAtIndex:6] stringValue];
                detail.imageArray = imageArray;
                detail.youtubeKey = [[ele childAtIndex:8] stringValue];
                detail.content = [[ele childAtIndex:9] stringValue];
                detail.date = [[ele childAtIndex:10] stringValue];
                detail.status = [NSNumber numberWithInteger:[[[ele childAtIndex:11] stringValue] integerValue]];
                [array addObject:detail];
                [detail release];
            }
        }
        items = [xmlDoc nodesForXPath:answerXpath error:nil];
        for (GDataXMLElement *ele in items)
        {
            NSLog(@"ans:%@",[[ele childAtIndex:1] stringValue]);
            NSString *tmpString = [[ele childAtIndex:1] stringValue];
            NSString *imageString = [[ele childAtIndex:5] stringValue];
            NSArray *imageArray = [imageString componentsSeparatedByString:@","];
            if ([tmpString isEqualToString:@"1"])
            {
                answerDetail *detail = [[answerDetail alloc] init];
                detail.seq = [NSNumber numberWithInteger:[[[ele childAtIndex:0] stringValue] integerValue]];
                detail.type = [NSNumber numberWithInteger:[tmpString integerValue]];
                detail.replyid = [[ele childAtIndex:2] stringValue];
                detail.replierid = [[ele childAtIndex:3] stringValue];
                detail.replier = [[ele childAtIndex:4] stringValue];
                detail.imageArray = imageArray;
                detail.youtubeKey = [[ele childAtIndex:6] stringValue];
                detail.content = [[ele childAtIndex:7] stringValue];
                detail.date = [[ele childAtIndex:10] stringValue];
                [array addObject:detail];
                [detail release];
            }
        }
        resultList = [[NSArray alloc] initWithArray:array];
    }
    else if (type == MyPostDelegateTypeLogin)
    {
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        if (xmlDoc == nil)
            return NO;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        [array addObject:responseData];
        resultList = [[NSArray alloc] initWithArray:array];;
    }
    else if (type == MyPostDelegateTypeSignup)
    {
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        if (xmlDoc == nil)
            return NO;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        [array addObject:responseData];
        resultList = [[NSArray alloc] initWithArray:array];
    }
    else if (type == MyPostDelegateTypeAskQuestion | type == MyPostDelegateTypeReplyQuestion)
    {
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        if (xmlDoc == nil)
            return NO;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSArray *items = [xmlDoc nodesForXPath:uploadStatusXpath error:nil];
        for (GDataXMLElement *ele in items)
        {
            NSLog(@"upload:%@",[ele stringValue]);
            uploadResult *upload = [[uploadResult alloc] init];
            upload.errorCode = [[ele stringValue] intValue];
            [array addObject:upload];
            [upload release];
        }
        resultList = [[NSArray alloc] initWithArray:array];
    }
    else if (type == MyPostDelegateTypeNewsDetail)
    {
        xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData options:0 error:nil];
        if (xmlDoc == nil)
            return YES;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSArray *items = [xmlDoc nodesForXPath:newsDetailIdXpath error:nil];
        if ([items count] == 1)
        {
            newsDetail *detail = [[newsDetail alloc] init];
            GDataXMLElement *ele = [items objectAtIndex:0];
            detail.newsId = [[ele childAtIndex:0] stringValue];
            detail.releaseDate = [[ele childAtIndex:1] stringValue];
            detail.title = [[ele childAtIndex:2] stringValue];
            detail.content = [[ele childAtIndex:3] stringValue];
            [array addObject:detail];
            [detail release];
        }
        resultList = [[NSArray alloc] initWithArray:array];
    }
    xmlDoc = nil;
    return YES;
}
- (void)cancelPost
{
    [connection cancel];
}
- (void)cancelAsiPost
{
    [ASIrequest cancel];
}
- (void)dealloc
{
    [resultList release], resultList = nil;
    [super dealloc];
}
#pragma mark - NSURLconnection delegate
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];    
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    [responseData release], responseData = nil;
    [delegate MyPostDelegate:self didFailWithError:error];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    resultList = [[NSMutableArray alloc] init];
    if (![self parseXml])
        [delegate MyPostDelegate:self didFailParseXmlWithError:nil];
    else
        [delegate MyPostDelegate:self didFinishPost:resultList];
    [responseData release], responseData = nil;
}

#pragma mark - ASI delegate

- (void)asiFaild:(ASIHTTPRequest*)request
{
    [delegate MyPostDelegate:self didFailWithError:[request error]];
}
- (void)asiFinished:(ASIHTTPRequest*)request
{
    
    NSLog(@"retuestString:%@",[request responseString]);
    responseData = [NSData dataWithData:[request responseData]];
    if (![self parseXml])
        [delegate MyPostDelegate:self didFailParseXmlWithError:nil];
    else
        [delegate MyPostDelegate:self didFinishPost:resultList];
}
@end
