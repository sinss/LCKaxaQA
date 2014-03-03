//
//  AskTableViewController.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/2.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPictureTableViewCell.h"
#import "customImgaeView.h"
#import "customTextViewController.h"
#import "questionInfo.h"
#import "infoPanel.h"
#import "UIImage+Resize.h"
#import "ProcessImage.h"
#import "EGOPhotoGlobal.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"
#import "customPickCourseViewController.h"
#import "customPickEducationViewController.h"
#import "topicSelectViewController.h"
#import "customSingleTextFieldCell.h"
#import "customSingleLabelCell.h"
#import "MyPostDelegate.h"
#import "AccountCheck.h"
#import "NSData+Base64.h"

enum
{
    askTableViewOptionPicture = 0,
    askTableViewOptionTopic = 1,
    askTableViewOptionTitle = 2,
    askTableViewOptionContent = 3
};
typedef NSInteger askTableViewOption;

enum
{
    askChoosePhotoSourceTypeCamera = 0,
    askChoosePhotoSourceTypeAlbum = 1
};
typedef NSInteger askChoosePhotoSourceType;

enum
{
    askQuestionActionCreate = 0,
    askQuestionActionReply = 1
};
typedef NSInteger askQuestionAction;

@class AskTableViewController;
@protocol AskTableViewDelegate <NSObject>

- (void) askTableView:(AskTableViewController*)view didFinishUploadData:(BOOL)statusInd;

@end

@interface AskTableViewController : UITableViewController
<MyPictureTableViewCellDelegate, customTextViewDelegate,
UINavigationControllerDelegate, UIImagePickerControllerDelegate,
UIActionSheetDelegate, UITextFieldDelegate, postDelegate, topicSelectAction>
{
    id<AskTableViewDelegate> delegate;
    askQuestionAction questionType;
    NSString *theme;
    NSArray *resultList;
    NSArray *introList;
    NSIndexPath *currentIndexPath;
    questionDetail *newInfo;
    NSString *discussid;
    MyPostDelegate *poster;
    UIAlertView *alert;
    UIProgressView *postProgessBar;
    BOOL alertNeedClose;
    
    loginInfo *accountInfo;
}

@property (nonatomic, retain) questionDetail *currInfo;
@property (nonatomic ,retain) NSString *discussid;
@property (nonatomic ,retain) NSString *theme;
@property (assign) id<AskTableViewDelegate> delegate;

- (id)initWithStyle:(UITableViewStyle)style AndQuestionType:(NSInteger)type;

@end
