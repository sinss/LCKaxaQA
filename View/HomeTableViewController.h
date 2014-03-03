//
//  HomeTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPostDelegate.h"
#import "GlobalFunctions.h"
#import "AskTableViewController.h"
#import "loginInfo.h"
#import "AccountCheck.h"
#import "infoPanel.h"
#import "newsInfo.h"
#import "newsInfo2.h"
#import "customReplyTableViewCell.h"
#import "QuestionDetailTableViewController.h"
#import "loginTableViewController.h"
#import "SignupTableViewController.h"
#import "customDetailViewController.h"
#import "newsTableViewCell.h"
#import "PullRefreshTableViewController.h"

@interface HomeTableViewController : PullRefreshTableViewController
<UIAlertViewDelegate, postDelegate,
UIActionSheetDelegate, loginTableViewDelegate, signupTableViewDelegate>
{
    NSArray *newsList;
    NSArray *replyList;
    MyPostDelegate *poster;
    UIAlertView *alert;
    BOOL alertNeedClose;

    loginInfo *accountInfo;
}

@end
