//
//  QuestionDetailTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "answerInfo.h"
#import "questionInfo.h"
#import "MyPostDelegate.h"
#import "GlobalFunctions.h"
#import "customQuestionDetailCell2.h"
#import "AskTableViewController.h"
#import "EGOPhotoGlobal.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"
#import "ImageCropper.h"
#import "PullRefreshTableViewController.h"

enum
{
    detailViewOptionQuestion = 0,
    detailViewOptionAnswer = 1
};
typedef NSInteger detailViewOption;

enum
{
    questionRowImage = 0,
    questionRowTitle = 1,
    questionRowContent = 2,
    questionRowClass = 3
};
typedef NSInteger questionRow;

enum
{
    answerRowImage = 0,
    answerRowTitle = 1,
    answerRowContent = 2,
};
typedef NSInteger answerRow;

@class questionDetail;

@interface QuestionDetailTableViewController : PullRefreshTableViewController
<UITableViewDelegate, UITableViewDataSource, postDelegate, questionDetailDelegate, ImageCropperDelegate,
AskTableViewDelegate>
{
    NSString *discussid;
    NSString *theme;
    NSArray *questionArray;
    NSArray *answerTitleArray;
    NSArray *answerArray;
    MyPostDelegate *poster;
    UIAlertView *alert;
    BOOL alertNeedClose;
    BOOL isLoad;
}

@property (nonatomic, retain) NSString *theme;
@property (nonatomic, retain) NSString *discussid;

@end
