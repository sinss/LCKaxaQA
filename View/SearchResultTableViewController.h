//
//  SearchResultTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/1/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "MyPostDelegate.h"
#import "questionInfo.h"
#import "QuestionDetailTableViewController.h"
#import "loginInfo.h"
#import "infoPanel.h"
#import "AccountCheck.h"

@interface SearchResultTableViewController : UITableViewController 
<SearchViewDelegate, UIAlertViewDelegate, postDelegate>
{
    NSArray *resultList;
    BOOL kaxaNetReachStatus;
    
    MyPostDelegate *poster;
    UIAlertView *alert;
    BOOL alertNeedClose;
    
    NSInteger currentEducationInd;
    NSInteger currentCourseInd;
    NSString *currentSearchKey;
    
    loginInfo *accountInfo;
}


@end
