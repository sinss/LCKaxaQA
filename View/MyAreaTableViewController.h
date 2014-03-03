//
//  MyAreaTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPostDelegate.h"
#import "GlobalFunctions.h"
#import "questionInfo.h"
#import "customReplyTableViewCell.h"
#import "QuestionDetailTableViewController.h"
#import "loginTableViewController.h"
#import "SignupTableViewController.h"
#import "AccountCheck.h"
#import "infoPanel.h"
#import "PullRefreshTableViewController.h"

@interface MyAreaTableViewController : PullRefreshTableViewController
<postDelegate, UIAlertViewDelegate, UIActionSheetDelegate,
loginTableViewDelegate, signupTableViewDelegate>
{
    NSArray *questionArray;
    NSArray *replyArray;
    NSArray *subscribeArray;
    BOOL kaxaNetReachStatus;
    
    MyPostDelegate *poster;
    UIAlertView *alert;
    BOOL alertNeedClose;
    
    loginInfo *accountInfo;
}

@end
