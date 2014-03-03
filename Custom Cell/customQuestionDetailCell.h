//
//  customQuestionDetailCell.h
//  KaxaQ&A
//
//  Created by 張星星 on 12/2/5.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customImgaeView.h"

@class customQuestionDetailCell;
@protocol customQuestionDetailDelegate <NSObject>

- (void)questionDetail:(customQuestionDetailCell*)cell didViewLargeImage:(NSInteger)buttonIndex withImage:(UIImage*)image;
- (void)questionDetail:(customQuestionDetailCell *)cell didSaveImage:(NSInteger)buttonIndex withImage:(UIImage*)image;

@end


@interface customQuestionDetailCell : UITableViewCell
{
    customImgaeView *imageView;
    IBOutlet UIButton *viewLargeButton;
    IBOutlet UIButton *saveImageButton;
    id<customQuestionDetailDelegate> delegate;
}
@property (assign) id<customQuestionDetailDelegate> delegate;

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;
- (IBAction)viewLargeButtonPress:(UIButton*)sender;
- (IBAction)saveImageButtonPress:(UIButton*)sender;

@end
