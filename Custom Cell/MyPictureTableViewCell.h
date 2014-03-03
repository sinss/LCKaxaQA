//
//  MyPictureTableViewCell.h
//  ClockReminder
//
//  Created by 張星星 on 11/12/15.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    MyPictureTableViewCellButtonTypeTakeNewPicture = 0,
    MyPictureTableviewCellButtonTypeViewOriginalPciture = 1
};
typedef NSInteger MyPictureTableViewCellButtonType;
enum
{
    MyPictureSourceTypeCamera = 0,
    MyPictureSourceTypePhotoLibrary = 1,
    MyPictureSourceTypeNone = 2
};
typedef NSInteger MyPictureSourceType;
//delegate
@class MyPictureTableViewCell;
@protocol MyPictureTableViewCellDelegate <NSObject>

- (void)MyPictureTableViewCell:(MyPictureTableViewCell*)cell didPressButton:(MyPictureTableViewCellButtonType)pressButtonIndex;

@end

@interface MyPictureTableViewCell : UITableViewCell
{
    id<MyPictureTableViewCellDelegate> delegate;
    UIImageView *reminderImageView;
    UIImage *reminderImage;
    IBOutlet UIButton *takePictureButton;
    IBOutlet UIButton *viewLargeButton;
}

@property (assign) id<MyPictureTableViewCellDelegate> delegate;
@property (nonatomic ,retain) UIImage *reminderImage;
@property (nonatomic, retain) IBOutlet UIImageView *reminderImageView;

- (void)setButtonImage;
- (IBAction)pressTakeNewPictureButton:(id)sender;
- (IBAction)pressViewOriginPictureButton:(id)sender;
@end